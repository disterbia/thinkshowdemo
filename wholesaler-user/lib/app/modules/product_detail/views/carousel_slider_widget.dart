import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';

class ImagesCarouselSlider extends StatelessWidget {
  ImagesCarouselSlider();
  ProductDetailController ctr = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    double height = Get.width * 4 / 3;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Obx(
          () => CarouselSlider(
            carouselController: ctr.indicatorSliderController,
            options: CarouselOptions(
                height: height,
                autoPlay: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  ctr.sliderIndex.value = index;
                }),
            items: [
              for (String img in ctr.product.value.images!)
                CachedNetworkImage(
                  imageUrl: img,
                  // placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          child: Obx(
            () => _indicator(ctr.product.value.images!),
          ),
        ),
      ],
    );
  }

  Widget _indicator(List<String> imgList) {
    print('inisde _indicator imgList $imgList');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
              // onTap: () => ctr.indicatorSliderController.animateToPage(entry.key),
              child: Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(shape: BoxShape.circle, color: MyColors.primary.withOpacity(ctr.sliderIndex.value == entry.key ? 0.9 : 0.4)),
          ));
        }).toList(),
      ),
    );
  }

  // Widget _indicator(List<String> imgList) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //     child: Obx(
  //       () => Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: imgList.asMap().entries.map((entry) {
  //           return GestureDetector(
  //               onTap: () => ctr.indicatorSliderController.animateToPage(entry.key),
  //               child: Container(
  //                 width: 10.0,
  //                 height: 10.0,
  //                 margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
  //                 decoration: BoxDecoration(shape: BoxShape.circle, color: MyColors.primary.withOpacity(ctr.sliderIndex.value == entry.key ? 0.9 : 0.4)),
  //               ));
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }
}
