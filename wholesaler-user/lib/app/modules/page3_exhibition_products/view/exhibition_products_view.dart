import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/modules/page3_exhibition_products/controller/exhibit_product_controller.dart';
import 'package:wholesaler_user/app/modules/search/views/search_page_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class ExhibitionProductsView extends GetView {
  ExhibitionProductsController ctr = Get.put(ExhibitionProductsController());

  ExhibitionProductsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  Widget _body() => SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => ctr.bannerPicture != ''
                  ? CachedNetworkImage(
                      imageUrl: ctr.bannerPicture.value,
                      fadeInDuration: Duration(milliseconds: 0),
                      fadeOutDuration: Duration(milliseconds: 0),
                      placeholderFadeInDuration: Duration(milliseconds: 0),
                      width: Get.width,
                      fit: BoxFit.fitWidth,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : LoadingWidget(),
            ),
            SizedBox(height: 15),
            Obx(
              () => Center(
                child: Text(
                  ctr.title.value,
                  style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ProductGridViewBuilder(
                crossAxisCount: 3,
                productHeight: 280,
                products: ctr.products,
                isShowLoadingCircle: false.obs,
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      );

  AppBar _appbar() {
    return CustomAppbar(isBackEnable: true, title: 'Exhibition_product'.tr, actions: [
      IconButton(
        icon: Icon(
          Icons.search,
          color: MyColors.black,
        ),
        onPressed: () {
          Get.to(() => SearchPageView());
        },
      ),
      IconButton(
          onPressed: () {
            Get.to(() => Cart1ShoppingBasketView());
          },
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: MyColors.black,
          ))
    ]);
  }

  loadWithDelay() {}
}
