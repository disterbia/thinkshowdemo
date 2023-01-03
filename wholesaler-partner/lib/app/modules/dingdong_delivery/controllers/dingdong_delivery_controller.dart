import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';

class DingdongDeliveryController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  final pApiProvider _apiProvider = pApiProvider();

  RxString selectedSortProductDropDownItem = SortProductDropDownItem.latest.obs;

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;

  @override
  void onInit() {
    super.onInit();

    scrollController.value.addListener(() {
      // print('scrollController.value.position.pixels: ${scrollController.value.position.pixels}');
      if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent && allowCallAPI.isTrue) {
        offset += mConst.limit;
        callGetProductsAPI(isScrolling: true);
      }
    });
  }

  Future<void> callGetProductsAPI({String? sort, required bool isScrolling}) async {
    dynamic raw = await _apiProvider.getProducts(isDingDong: true, sort: sort, offset: offset, limit: mConst.limit);

    log('getProducts raw $raw length ${raw.length}');

    if (!isScrolling) {
      offset = 0;
      products.clear();
    }

    for (int i = 0; i < raw.length; i++) {
      Product tempProduct = Product(
        id: raw[i]['id'],
        title: raw[i]['product_name'],
        price: raw[i]['price'],
        imgUrl: raw[i]['thumbnail_image_url'],
        store: Store(id: -1),
        isLiked: raw[i]['is_favorite'] ? true.obs : false.obs,
        hasBellIconAndBorder: true.obs,
      );
      products.add(tempProduct);
    }

    print('raw length ${raw.length}');

    if (raw.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }

  sortDropDownChanged(String selectedItem) {
    print('selected $selectedItem');
    selectedSortProductDropDownItem.value = selectedItem;
    callGetProductsAPI(sort: selectedItem, isScrolling: false);
  }
}
