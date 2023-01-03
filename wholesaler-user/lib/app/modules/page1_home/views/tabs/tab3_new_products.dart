import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab3_new_products_controller.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/controller/carousal_product_horizontal_controller.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/controller/carousal_product_horizontal_controller_new.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/view/carousal_product_horizontal_view.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/view/carousal_product_horizontal_view_new.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class Tab3NewProductsView extends GetView<Tab3NewProductsController> {
  Tab3NewProductsController ctr = Get.put(Tab3NewProductsController());
  CarousalProductHorizontalControllerNew newRecommendedProductCtr = Get.put(CarousalProductHorizontalControllerNew());

  Tab3NewProductsView();

  init() {
    ctr.init();
    //Get.delete<CarousalProductHorizontalControllerNew>();
    newRecommendedProductCtr.init();
  }

  @override
  Widget build(BuildContext context) {
    init();
   // print('tab3 new products');
    return Obx(
      ()=>ctr.isLoading.value&&newRecommendedProductCtr.isLoading.value ? LoadingWidget(): SingleChildScrollView(
        controller: ctr.scrollController.value,
        child: Column(
          children: [
            newRecommendedProductCtr.products.length!=0? Column(
                      children: [
                        _sponsorTitle(),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CarousalProductHorizontalViewNew(),
                        ),
                        Divider(thickness: 6, color: MyColors.grey3),
                      ],
                    ):Container()
             ,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ctr.isLoading.value ? LoadingWidget():ProductGridViewBuilder(
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

  Widget _sponsorTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Sponsored',
            style: MyTextStyles.f14.copyWith(color: MyColors.grey4),
          )
        ],
      ),
    );
  }

  // Widget _indicator(List<Product> imgList) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: imgList.asMap().entries.map((entry) {
  //         return GestureDetector(
  //             onTap: () => ctr.indicatorSliderController.animateToPage(entry.key),
  //             child: Container(
  //               width: 10.0,
  //               height: 10.0,
  //               margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
  //               decoration: BoxDecoration(shape: BoxShape.circle, color: MyColors.primary.withOpacity(ctr.sliderIndex.value == entry.key ? 0.9 : 0.4)),
  //             ));
  //       }).toList(),
  //     ),
  //   );
  // }
}
