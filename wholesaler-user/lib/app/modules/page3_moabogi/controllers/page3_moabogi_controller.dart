import 'dart:developer';

import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/modules/page1_home/models/image_banner_model.dart';
import 'package:wholesaler_user/app/modules/page3_product_category_page/view/product_category_page_view.dart';

class Page3MoabogiController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();
  RxBool isLoading = false.obs;
  RxList<ImageBannerModel> imageBanners = <ImageBannerModel>[].obs;

  getBannerData() async {
    isLoading.value=true;
    imageBanners.value = await _apiProvider.getBannerImageList();
    isLoading.value=false;
  }

  void chipPressed(int index) {
  //  print('tapped main category index $index');
    Get.to(() => ProductCategoryPageView(index));
  }
}
