import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/search_product_auto_model.dart';
import 'package:wholesaler_user/app/models/search_store_auto_model.dart';

class SearchPageController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();
  TextEditingController searchController = TextEditingController();
  RxList<SearchStoreAutoModel> storeResults = <SearchStoreAutoModel>[].obs;
  RxList<SearchProductAutoModel> keywordResults = <SearchProductAutoModel>[].obs;
  int maxTotalStoreResults = 2;
  int maxTotalKeywordResults = 5;
  RxBool showSearchProductList = false.obs;

  RxList<Product> searchProducts = <Product>[].obs;
  RxList<Product> recentlyVisitedProducts = <Product>[].obs;

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    // Recently Seen Products
    List productIds = CacheProvider().getAllRecentlyViewedProducts();
    //print('productIds ${productIds}');
    if (productIds.isNotEmpty) {
      recentlyVisitedProducts.value = await _apiProvider.getRecentlySeenProducts(productIds);
      if (recentlyVisitedProducts.length < mConst.limit) {
        allowCallAPI.value = false;
      }
    }

    scrollController.value.addListener(() {
     // print('scrollController.value.addListener');
      if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent && allowCallAPI.isTrue) {
        offset += mConst.limit;
        addDataToList();
      }
    });
  }

  updateSearch(String searchContent) async {
    if (searchContent == '') {
      return;
    }
    showSearchProductList.value = false;
    storeResults.value = await _apiProvider.getSearchStoreAutoComplete(searchContent: searchContent);
    keywordResults.value = await _apiProvider.getSearchKeywordAutoComplete(searchContent: searchContent);
  }

  searchProductsResult(String keyword) async {
    searchController.text = keyword;
    // check if empty
    if (keyword == '') {
      return;
    }
    allowCallAPI.value = true;
    offset = 0;
    searchProducts.clear();
    searchProducts.value = await _apiProvider.getSearchProducts(searchContent: searchController.text, offset: offset, limit: mConst.limit);
    showSearchProductList.value = true;

    if (searchProducts.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }

  addDataToList() async {
    List<Product> tempProducts = [];
    tempProducts = await _apiProvider.getSearchProducts(searchContent: searchController.text, offset: offset, limit: mConst.limit);
   // print('tempProducts length ${tempProducts.length}');
    searchProducts.addAll(tempProducts);

    // check if last product from server.
    if (tempProducts.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }
}
