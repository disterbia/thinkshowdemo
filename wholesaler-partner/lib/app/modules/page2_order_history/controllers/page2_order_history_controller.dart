import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/models/order_response.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';

import '../../../data/api_provider.dart';

class Page2OrderHistoryController extends GetxController {
  pApiProvider apiProvider = pApiProvider();
  RxBool isLoading = false.obs;
  RxList<Product> products = <Product>[].obs;
  RxInt totalAmount = 0.obs;

  late TextEditingController startDateController;
  late TextEditingController endDateController;

  List<String> orderStatus = [
    'order_completed'.tr,
    'Packing_completed'.tr,
    'Delivery_completed'.tr
  ];

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;

  void init() async{
    print('PartnerHomeController init');
   // WidgetsBinding.instance.addPostFrameCallback((_) async{
      // isShowSplashScreen.value = false;
      isLoading.value=true;
    var date = DateTime.now();
    var prevMonth = DateTime(date.year, date.month - 3, date.day);
    startDateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    endDateController =
        TextEditingController(text: DateFormat('yyyy-MM-dd').format(prevMonth));
      await getOrders(isScrolling: false);
      isLoading.value=false;
   // });
  }
  @override
  void onInit() async {
    super.onInit();
    scrollController.value.addListener(() {
      // print('scrollController.value.position.pixels: ${scrollController.value.position.pixels}');
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          allowCallAPI.isTrue) {
        offset += mConst.limit;
        getOrders(isScrolling: true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }

  Future<void> getOrders({required bool isScrolling}) async {
    if (isScrolling == false){
      offset=0;
      products.clear();
    }
    OrderResponse response = await apiProvider.getOrders(
        startDate: endDateController.text,
        endDate: startDateController.text,
        offset: offset,
        limit: mConst.limit);


    for (var element in response.orders!) {
      products.add(
        Product(
          id: element.productId!,
          title: element.productName.toString(),
          price: element.productPrice,
          OLD_option: element.productOptionName,
          quantity: element.orderQty!.obs,
          imgHeight: 100,
          imgWidth: 80,
          imgUrl: element.productThumbnailUrl.toString(),
          store: Store(id: 1),
          createdAt: element.createdAt,
        ),
      );
    }
    totalAmount.value = response.totalAmount ?? 0;
    if (response.orders!.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }
}
