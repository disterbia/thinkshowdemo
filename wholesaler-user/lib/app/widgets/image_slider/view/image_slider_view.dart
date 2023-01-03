import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/modules/page1_home/models/image_banner_model.dart';
import 'package:wholesaler_user/app/widgets/image_slider/controller/image_slider_controller.dart';

import '../../../modules/page3_exhibition_products/view/exhibition_products_view.dart';

class ImageSliderView extends GetView<ImageSliderController> {
  ImageSliderController ctr = Get.put(ImageSliderController());

  CurrentPage currentPage;
  ImageSliderView(this.currentPage);

  @override
  Widget build(BuildContext context) {
    ctr.getBannerImageAPI(currentPage);

    return Stack(children: [
      Obx(
        () => CarouselSlider(
          carouselController: ctr.sliderController,
          items: [
            for (ImageBannerModel image in ctr.imageBannerModel)
              GestureDetector(
                onTap: () {
                  if (currentPage != CurrentPage.dingDongPage) {
                    Get.to(() => ExhibitionProductsView(), arguments: {'imageId': image.id});
                  }
                },
                child: Container(
                  width: Get.width,
                  child: CachedNetworkImage(
                    imageUrl: image.banner_img_url,
                    width: Get.width,
                    fit: BoxFit.cover,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
          ],
          options: CarouselOptions(
            pageSnapping: true,
            onPageChanged: (index, reason) {
              ctr.mainSliderIndex.value = index;
            },
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.999,
          ),
        ),
      ),
      Obx(
        () => Positioned(
          bottom: 3,
          right: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 20,
              width: 40,
              decoration: BoxDecoration(color: MyColors.black.withOpacity(0.5), borderRadius: BorderRadius.all(Radius.circular(MyDimensions.circle))),
              child: Center(
                child: Text(
                  '${(ctr.mainSliderIndex.value) + 1}/${ctr.imageBannerModel.length}',
                  style: TextStyle(color: MyColors.white),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
