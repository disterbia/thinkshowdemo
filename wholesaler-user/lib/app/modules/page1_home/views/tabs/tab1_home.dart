import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab1_user_home_controller.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/controller/carousal_product_horizontal_controller.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/view/carousal_product_horizontal_view.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/image_slider/controller/image_slider_controller.dart';
import 'package:wholesaler_user/app/widgets/image_slider/view/image_slider_view.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class Tab1HomeView extends GetView<Tab1UserHomeController> {
  Tab1UserHomeController ctr = Get.put(Tab1UserHomeController());
 // CategoryTagController categoryTagCtr = Get.put(CategoryTagController());
 //  Page1HomeController page1HomeCtr = Get.put(Page1HomeController());
  CarousalProductHorizontalController recommendedProductCtr = Get.put(CarousalProductHorizontalController());

  init() {
    ctr.init();
    //Get.delete<CarousalProductHorizontalController>();
    recommendedProductCtr.init();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Obx(
       ()=> ctr.isLoading.value&&recommendedProductCtr.isLoading.value ? LoadingWidget():SingleChildScrollView(
        controller: ctr.scrollController.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageSliderView(CurrentPage.homePage),
            // SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: _dingdongBanner(),
            // ),
            // SizedBox(height: 20),
            recommendedProductCtr.products.length!=0?Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          _recommendedItemsTitle(),
                          CarousalProductHorizontalView(),
                        ],
                      ),
                    ):Container()

            ,
            Divider(thickness: 6, color: MyColors.grey3),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Obx(
                () => HorizontalChipList().getAllMainCat(
                    categoryList: ClothCategory.getAllMainCat().map((e) => e.name).toList(),
                    onTapped: () {
                      ctr.updateProducts();
                    }),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ProductGridViewBuilder(
                crossAxisCount: 3,
                productHeight: 280,
                products: ctr.products,
                isShowLoadingCircle: ctr.allowCallAPI,
              ),
            ),
          ],
        ),
    ),
     );
  }

  // Widget _dingdongBanner() {
  //   return GestureDetector(
  //     onTap: () {
  //       print('dingdong_delivery_banner tap detected. ');
  //       page1HomeCtr.tabBarIndex.value = UserHomeTabs.dingdong.index;
  //       print('page1HomeCtr.tabBarIndex.value ${page1HomeCtr.tabBarIndex.value}');
  //     },
  //     child: Container(
  //       child: Image.asset(
  //         'assets/images/dingdong_delivery_banner.png',
  //       ),
  //     ),
  //   );
  // }

  Widget _recommendedItemsTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'recommended_item'.tr,
            style: MyTextStyles.f16,
          ),
          Text(
            'Sponsored',
            style: MyTextStyles.f14.copyWith(color: MyColors.black1),
          )
        ],
      ),
    );
  }
}
