import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';

class Tab2BestController extends GetxController {
  CategoryTagController categoryTagCtr = Get.put(CategoryTagController());
  uApiProvider _apiProvider = uApiProvider();
  RxList<Product> products = <Product>[].obs;
  Rx<ScrollController> scrollController = ScrollController().obs;
  RxBool allowCallAPI = false.obs;
  RxBool isLoading = false.obs;
  int offset = 0;

  /// WARNING: [apiSoftItems] and [dropdownItems]: if one is changed, the other one should also be changed.
  List<String> apiSoftItems = ['total', 'daily', 'weekly', 'lowPrice', 'highPrice'];
  List<String> dropdownItems = ['전체', '일간베스트', '주간베스트', '낮은가격순', '높은가격순'];
  RxInt selectedDropdownIndex = 0.obs;

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    products.value = await _apiProvider.getBestProductsWithALL(sort: apiSoftItems[categoryTagCtr.selectedMainCatIndex.value]);
    isLoading.value = false;
    // scrollController.value.addListener(() {
    //   if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent && allowCallAPI.isTrue) {
    //     offset += mConst.limit;
    //     addDataToList();
    //   }
    // });
    super.onInit();
  }

  Future<void> updateProducts() async {
    isLoading.value = true;
    //print('inside updateProducts: categoryTagCtr selectedIndex ${categoryTagCtr.selectedMainCatIndex.value}');
    // Note: we have two APIs. API 1: When "ALL" chip is called (index == 0), API 2: when categories are called.
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
    //  print('index 0, show ALL');
      products.value = await _apiProvider.getBestProductsWithALL(sort: apiSoftItems[selectedDropdownIndex.value]);
    } else {
    //  print('index > 0 , show categories');
      products.value = await _apiProvider.getBestProductsWithCat(categoryId: categoryTagCtr.selectedMainCatIndex.value, sort: apiSoftItems[selectedDropdownIndex.value]);
    }
    isLoading.value = false;
  }

  // addDataToList() async {
  //   List<Product> tempProducts = [];
  //   if (categoryTagCtr.selectedMainCatIndex.value == 0) {
  //     print('index 0, show ALL');
  //     tempProducts = await _apiProvider.getAllProducts(offset: offset, limit: mConst.limit);
  //   } else {
  //     print('index > 0 , show categories');
  //     tempProducts = await _apiProvider.getProductsWithCat(categoryId: categoryTagCtr.selectedMainCatIndex.value, offset: offset, limit: mConst.limit);
  //   }
  //   products.addAll(tempProducts);
  //   // check if last product from server.
  //   if (tempProducts.length == 0) {
  //     allowCallAPI.value = false;
  //   }
  // }
}
