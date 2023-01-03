import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/cloth_category_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';

class ProductCategoryPageController extends GetxController {
  uApiProvider apiProvider = uApiProvider();
  RxInt selectedCatIndex = (-1).obs;
  RxList<Product> products = <Product>[].obs;
  late int selectedMainCatIndex;
  late String title;
  ClothCategoryModel selectedSubcat = ClothCategoryModel(id: -1, name: 'name', parentId: -2, depth: -3, isUse: false);

  List<String> apiSoftItems = ['latest', 'popular', 'review'];
  List<String> dropdownItems = ['최신순', '인기순', '리뷰순'];
  RxInt selectedDropdownIndex = 0.obs;

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;

  init() async {
    // print('inside ProductCategoryPageView > init > selectedMainCatIndex $selectedMainCatIndex');
    title = ClothCategory.getTitleAt(selectedMainCatIndex);
    selectedCatIndex.value = selectedMainCatIndex + 1;

    products.value = await apiProvider.getProductsWithCat(offset: offset, limit: mConst.limit, categoryId: selectedCatIndex.value, sort: apiSoftItems[selectedDropdownIndex.value]);

    if (products.length < mConst.limit) {
      allowCallAPI.value = false;
    }

    scrollController.value.addListener(() {
      // print('inside ProductCategoryPageView > init > scrollController.value.position.pixels ${scrollController.value.position.pixels}');
      if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent && allowCallAPI.isTrue) {
        offset += mConst.limit;
        updateProducts(isScrolling: true);
      }
    });
  }

  subCatChipPressed(ClothCategoryModel selectedSubcat) async {
    // print('selectedSubcat id: ${selectedSubcat.id}');
    // print('selectedSubcat parentId: ${selectedSubcat.parentId}');
    selectedCatIndex.value = selectedSubcat.id;
    // reset variables
    products.clear();
    offset = 0;
    allowCallAPI.value = true;
    products.value = await apiProvider.getProductsWithCat(offset: offset, limit: mConst.limit, categoryId: selectedCatIndex.value, sort: apiSoftItems[selectedDropdownIndex.value]);

    if (products.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }

  updateProducts({required bool isScrolling}) async {
    List<Product> tempProducts = [];
    tempProducts = await apiProvider.getProductsWithCat(offset: offset, limit: mConst.limit, categoryId: selectedCatIndex.value, sort: apiSoftItems[selectedDropdownIndex.value]);

    if (isScrolling) {
      products.addAll(tempProducts);
    } else {
      products.value = tempProducts;
    }
    // check if last product from server.
    if (tempProducts.length == 0) {
      allowCallAPI.value = false;
    }
  }
}
