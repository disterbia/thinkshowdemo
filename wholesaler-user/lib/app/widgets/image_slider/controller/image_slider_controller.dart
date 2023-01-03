import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/modules/page1_home/models/image_banner_model.dart';

enum CurrentPage {
  homePage,
  dingDongPage,
}

class ImageSliderController extends GetxController {
  uApiProvider apiProvider = uApiProvider();

  RxInt mainSliderIndex = 0.obs;
  CarouselController sliderController = CarouselController();
  RxList<ImageBannerModel> imageBannerModel = <ImageBannerModel>[].obs;

  Future<void> getBannerImageAPI(CurrentPage currentPage) async {
    if (currentPage == CurrentPage.homePage) {
      imageBannerModel.value = await apiProvider.getBannerImageList();
    } else if (currentPage == CurrentPage.dingDongPage) {
      imageBannerModel.value = await apiProvider.getDingdongBanners();
    }
  }
}
