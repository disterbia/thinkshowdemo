import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';

/// Warning Don't confuse [Tab1Home] with [Page1Home]. Inside Page1 we have tab1 with the name Home
class Tab1UserHomeController extends GetxController {
  CategoryTagController categoryTagCtr = Get.put(CategoryTagController());

  uApiProvider _apiProvider = uApiProvider();
  RxList<Product> products = <Product>[].obs;

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;
  RxBool isLoading= false.obs;

  // @override
  // Future<void> onInit() async {
  //
  // }

  Future<void> init() async{
    isLoading.value=true;
    products.value = await _apiProvider.getAllProducts(offset: 0, limit: mConst.limit);

    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent && allowCallAPI.isTrue) {
        offset += mConst.limit;
        addDataToList();
      }
    });
    isLoading.value=false;
    super.onInit();
  }

  Future<void> updateProducts() async {
    // reset variables
    products.clear();
    offset = 0;
    allowCallAPI.value = true;

    // Note: we have two APIs. API 1: When "ALL" chip is called (index == 0), API 2: when categories are called.
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
      print('index 0, show ALL');
      products.value = await _apiProvider.getAllProducts(offset: offset, limit: mConst.limit);
    } else {
      print('index > 0 , show categories');
      products.value = await _apiProvider.getProductsWithCat(categoryId: categoryTagCtr.selectedMainCatIndex.value, offset: offset, limit: mConst.limit);
    }
    if (products.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }

  addDataToList() async {
    List<Product> tempProducts = [];
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
      print('index 0, show ALL');
      tempProducts = await _apiProvider.getAllProducts(offset: offset, limit: mConst.limit);
    } else {
      print('index > 0 , show categories');
      tempProducts = await _apiProvider.getProductsWithCat(categoryId: categoryTagCtr.selectedMainCatIndex.value, offset: offset, limit: mConst.limit);
    }
    products.addAll(tempProducts);
    // check if last product from server.
    if (tempProducts.length == 0) {
      allowCallAPI.value = false;
    }
  }
}
