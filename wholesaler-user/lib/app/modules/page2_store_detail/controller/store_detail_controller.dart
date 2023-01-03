import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/main_store_model.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';
import 'package:wholesaler_user/app/widgets/dingdong_3products_horiz/dingdong_3products_horiz_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class StoreDetailController extends GetxController {
  Dingdong3ProductsHorizController dingdong3productsHorizCtr = Get.put(Dingdong3ProductsHorizController());
  uApiProvider _apiProvider = uApiProvider();
  CategoryTagController categoryTagCtr = Get.put(CategoryTagController());

  RxInt storeId = (-1).obs;
  Rx<MainStoreModel> mainStoreModel = MainStoreModel().obs;

  RxList<Product> products = <Product>[].obs;
  RxList<Product> top10Products = <Product>[].obs;

  // carousel
  RxInt sliderIndex = 0.obs;
  CarouselController indicatorSliderController = CarouselController();

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;

  List<String> apiSoftItems = ['latest', 'popular', 'review'];
  List<String> dropdownItems = ['최신순', '인기순', '리뷰순'];
  RxInt selectedDropdownIndex = 0.obs;

  init() async {
    mainStoreModel.value = await _apiProvider.getStoreDetailMainInfo(storeId.value);
    // Dingdong Products
    dingdong3productsHorizCtr.storeDingDongProducts(mainStoreModel.value);
    // top 10 products
    top10Products.value = await _apiProvider.getTop10Products(storeId: storeId.value);

    // products
    updateProducts(isScrolling: false);

    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent && allowCallAPI.isTrue) {
        offset += mConst.limit;
        updateProducts(isScrolling: true);
      }
    });
  }

  Future<void> starIconPressed() async {
    bool isSuccess = await _apiProvider.putAddStoreFavorite(storeId: mainStoreModel.value.storeId!);
    if (isSuccess) {
      mSnackbar(message: '스토어 찜 설정이 완료되었습니다.');
    }
  }

  privilateProductsNotEmpty() {
    return (mainStoreModel.value.privilegeProducts != null && mainStoreModel.value.privilegeProducts!.isNotEmpty);
  }

  Future<void> updateProducts({required bool isScrolling}) async {
    if (!isScrolling) {
      offset = 0;
      products.clear();
    }

    //print('inside updateProducts: selectedIndex ${categoryTagCtr.selectedMainCatIndex.value}');
    // Note: we have two APIs. API 1: When "ALL" chip is called (index == 0), API 2: when categories are called.
    List<Product> tempProducts = [];
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
     // print('index 0, show ALL');
      tempProducts = await _apiProvider.getAllProducts(offset: offset, limit: mConst.limit, storeId: storeId.value, sort: apiSoftItems[selectedDropdownIndex.value]);
    } else {
     // print('index > 0 , show categories');
      tempProducts = await _apiProvider.getProductsWithCat(
          categoryId: categoryTagCtr.selectedMainCatIndex.value, offset: offset, limit: mConst.limit, storeId: storeId.value, sort: apiSoftItems[selectedDropdownIndex.value]);
    }

    products.addAll(tempProducts);

    if (tempProducts.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }
}
