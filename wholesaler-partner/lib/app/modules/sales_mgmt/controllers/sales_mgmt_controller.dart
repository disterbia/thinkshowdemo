import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';

import '../../../data/api_provider.dart';

class SalesMgmtController extends GetxController with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  final pApiProvider _apiProvider = pApiProvider();
  String countOfProducts = '';
  final List<Tab> productTabs = [
    Tab(text: 'impressions'.tr),
    Tab(text: 'clicks'.tr),
    Tab(text: 'number_of_likes'.tr),
    Tab(text: 'number_of_orders'.tr),
  ];
  RxList<Product> products = <Product>[].obs;
  late TabController productTabController = TabController(length: 4, vsync: this, animationDuration: Duration.zero);

  // Rx<ScrollController> scrollController = ScrollController().obs;
  // int offset = 0;
  // RxBool allowCallAPI = false.obs;

  @override
  void onInit() async {
    print('inside SalesMgmtController onInit');
    await getProduct(type: 'exposure');
    productTabController.addListener(handleSelected);

    // scrollController.value.addListener(() {
    //   // print('scrollController.value.addListener ${scrollController.value.offset}');
    //   if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent) {
    //     if (productTabController.index == 3) {
    //       offset += mConst.limit;
    //       getProduct(type: 'order', isScrolling: true);
    //     }
    //   }
    // });
  }

  void handleSelected() async {
    print('inside SalesMgmtController handleSelected');
    if (productTabController.index == 0) {
      products.clear();
      // allowCallAPI.value = false;
      await getProduct(type: 'exposure');
    }
    if (productTabController.index == 1) {
      products.clear();
      // allowCallAPI.value = false;
      await getProduct(type: 'click');
    }
    if (productTabController.index == 2) {
      products.clear();
      // allowCallAPI.value = false;
      await getProduct(type: 'like');
    }
    if (productTabController.index == 3) {
      products.clear();
      // allowCallAPI.value = true;
      await getProduct(type: 'order');
    }
  }

  Future<void> getProduct({required String type, bool? isScrolling}) async {
    if (isScrolling == null || isScrolling == false) {
      isLoading.value = true;
    }
    dynamic response = await _apiProvider.getSaleProducts(type);
    if (response.length > 0) {
      countOfProducts = response['total_count'].toString();
      dynamic row = response['wholesale_report_list'];
      for (var i = 0; i < row.length; i++) {
        Product productData = Product(
          id: row[i]['id'],
          totalCount: row[i]['total_count'],
          title: row[i]['product_name'],
          price: row[i]['price'],
          imgHeight: 100,
          imgWidth: 80,
          imgUrl: row[i]['thumbnail_image_url'],
          store: Store(
            id: row[i]['store_id'],
            imgUrl: ''.obs,
            rank: 1,
          ),
        );

        products.add(productData);
      }
    }

    isLoading.value = false;
  }
}
