import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/controller/carousal_product_horizontal_controller.dart';

class Tab3NewProductsController extends GetxController {
  //CarouselController indicatorSliderController = CarouselController();
  RxInt sliderIndex = 0.obs;
  uApiProvider _apiProvider = uApiProvider();
  RxList<Product> products = <Product>[].obs;

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;
  RxBool isLoading = false.obs;

  Future<void> init() async {
    isLoading.value=true;
   // print('inside Tab3NewProductsController onInit');
    // delete old controllers
    // Get.delete<CarousalProductHorizontalController>();

    products.value = await _apiProvider.getNewProducts(offset: 0, limit: mConst.limit);
    isLoading.value=false;
    scrollController.value.addListener(() {
    //  print('scrollController.value.addListener');
      if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent && allowCallAPI.isTrue) {
      //  print('scrollController end detected. isLoading.value = ${allowCallAPI.value} offset = $offset');
        offset += mConst.limit;
      //  print('scrollController end detected. isLoading.value = ${allowCallAPI.value} offset = $offset');
        addDataToList();
      }
    });
    super.onInit();
  }

  addDataToList() async {
   // print('inside addDataToList: offset $offset');
    List<Product> tempProducts = await _apiProvider.getNewProducts(offset: offset, limit: mConst.limit);
    products.addAll(tempProducts);
    // check if last product from server.
    if (tempProducts.length == 0) {
      allowCallAPI.value = false;
    }
  }
}
