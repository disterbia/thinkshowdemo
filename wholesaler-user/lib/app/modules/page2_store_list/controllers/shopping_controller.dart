import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Page2StoreListController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxList<Store> stores = <Store>[].obs;
  RxBool isLoading = false.obs;

  Future<void> getRankedStoreData() async {
    Future.delayed(Duration.zero,() => isLoading.value=true);
    stores.value = await _apiProvider.getStoreRanking(offset: 0, limit: 80);
    isLoading.value=false;
  }

  Future<void> getBookmarkedStoreData() async {
    if (CacheProvider().getToken().isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.to(() => User_LoginPageView());
      });
    } else {
      Future.delayed(Duration.zero,() => isLoading.value=true);

      stores.value = await _apiProvider.getStorebookmarked();
      isLoading.value=false;
    }

  }

  Future<void> starIconPressed(Store store) async {
    if (CacheProvider().getToken().isEmpty) {
      Get.to(() => User_LoginPageView());
      return;
    }
    log('store id ${store.id}');
    bool isSuccess = await _apiProvider.putAddStoreFavorite(storeId: store.id);
    if (isSuccess) {
      mSnackbar(message: '스토어 찜 설정이 완료되었습니다.');
    }
  }
}
