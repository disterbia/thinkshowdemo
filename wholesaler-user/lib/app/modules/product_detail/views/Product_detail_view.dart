// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/carousel_slider_widget.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/select_option_bottom_sheet_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/tab1_detail_info_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/tab2_review_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/tab3_inquiry_view.dart';
import 'package:wholesaler_user/app/modules/search/views/search_page_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';

class ProductDetailView extends GetView {
  ProductDetailController ctr = Get.put(ProductDetailController());
  ProductDetailView();
  List<String> tabTitles = ['상세정보', '리뷰', '문의'];

  init() {
    //print("ddddddqqqqqq");
    if (Get.arguments != null) {
      CacheProvider().addRecentlyViewedProduct(Get.arguments);
     // print('ProductDetailView > addRecentlyViewedProduct: Get.arguments ${Get.arguments}');
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Obx(
      ()=> DefaultTabController(
        length: tabTitles.length,
        child: Scaffold(
          bottomNavigationBar: User_BottomNavbar(),
          backgroundColor: MyColors.white,
          appBar: _appbar(),
          body: ctr.isLoading.value?LoadingWidget():NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      MyVars.isUserProject() ? storeInfo() : Container(),
                      _productImages(),
                      _titleRatingPrice(),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: _tabs(),
                ),
              ];
            },
            body: tabViewBody(),
          ),
        ),
      ),
    );
  }

  Widget tabViewBody() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1DetailInfo(),
        Tab2ReviewView(),
        Tab3InquiryView(),
      ],
    );
  }

  Widget storeInfo() {
    return GestureDetector(
      onTap: () {
        Get.to(() => StoreDetailView(storeId: ctr.product.value.store.id));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Padding(
                padding: const EdgeInsets.all(15),
                child: ctr.product.value.store.imgUrl != null
                    ? Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(ctr.product.value.store.imgUrl!.value),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(ctr.product.value.store.name!)
                        ],
                      )
                    : Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_store.png',
                            width: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(() => ctr.product.value.store.name != null ? Text(ctr.product.value.store.name!) : SizedBox.shrink()),
                        ],
                      )),
          ),
          Obx(
            () => ctr.product.value.store.isBookmarked != null
                ? IconButton(
                    onPressed: () => ctr.storeBookmarkPressed(),
                    icon: ctr.product.value.store.isBookmarked!.isTrue
                        ? Icon(
                            Icons.star,
                            color: MyColors.primary,
                          )
                        : Icon(Icons.star_border, color: MyColors.primary),
                  )
                : SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  Widget _productImages() {
    // double height = Get.width * 4 / 3;
    return Container(
      child: Obx(
        () => ctr.product.value.images!.isNotEmpty ? ImagesCarouselSlider() : SizedBox.shrink(),
      ),
    );
  }

  Widget _titleRatingPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Text(
                  ctr.product.value.title,
                  style: MyTextStyles.f16,
                ),
              ),
            ),
            Obx(
              () => ctr.product.value.totalRating != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: MyColors.primary),
                          Text(
                            ctr.product.value.totalRating!.value.toString(),
                            textAlign: TextAlign.start,
                          )
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Utils.numberFormat(number: ctr.product.value.price ?? 0, suffix: '원'),
              style: MyTextStyles.f18_bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget User_BottomNavbar() {
    return SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              MyVars.isUserProject()
                  ? Obx(
                      () => ctr.product.value.isLiked != null
                          ? IconButton(
                              onPressed: () => ctr.likeBtnPressed(newValue: !ctr.product.value.isLiked!.value),
                              icon: ctr.product.value.isLiked!.isTrue
                                  ? Icon(
                                      Icons.favorite,
                                      color: MyColors.primary,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      color: MyColors.primary,
                                    ),
                            )
                          : SizedBox.shrink(),
                    )
                  : SizedBox.shrink(),
              Expanded(
                child: Row(
                  children: [
                    // MyVars.isUserProject()
                    //     ? IconButton(
                    //         onPressed: () => ctr.likeBtnPressed(),
                    //         icon: FaIcon(FontAwesomeIcons.heart),
                    //       )
                    //     : SizedBox.shrink(),
                    Expanded(
                      child: CustomButton(
                        textColor: MyColors.white,
                        text: MyVars.isUserProject() ? '구매하기' : '수정하기',
                        onPressed: () {
                          MyVars.isUserProject() ? SelectOptionBottomSheet() : ctr.editProductBtnPressed();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appbar() {
    return CustomAppbar(isBackEnable: true, hasHomeButton: true, title: '', actions: [
      MyVars.isUserProject()
          ? Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: MyColors.black,
                  ),
                  onPressed: () {
                    Get.to(SearchPageView());
                  },
                ),
                IconButton(
                  onPressed: () {
                    Get.to(() => Cart1ShoppingBasketView());
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: MyColors.black,
                  ),
                ),
              ],
            )
          : SizedBox.shrink(),
    ]);
  }

  Widget _tabs() {
    return TabBar(
      indicatorColor: MyColors.primary,
      labelColor: Colors.black,
      isScrollable: false,
      tabs: [
        ...tabTitles.map((title) => Tab(text: title)),
      ],
    );
  }
}
