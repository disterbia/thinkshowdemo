import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/modules/add_product/add_product_view.dart';
import 'package:wholesaler_partner/app/modules/dingdong_delivery/views/dingdong_delivery_view.dart';
import 'package:wholesaler_partner/app/modules/page1_home/controller/partner_home_controller.dart';
import 'package:wholesaler_partner/app/modules/page1_home/widgets/bulletin_item_widget.dart';
import 'package:wholesaler_partner/app/modules/payment/views/payment_view.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/controller/product_mgmt_controller.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/view/product_mgmt_view.dart';
import 'package:wholesaler_partner/app/modules/sales_mgmt/views/sales_mgmt_view.dart';
import 'package:wholesaler_partner/app/modules/top_10_products/views/top_10_products_view.dart';
import 'package:wholesaler_partner/app/widgets/bottom_navbar/bottom_navbar_controller.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_partner/app/widgets/search_field.dart';
import 'package:wholesaler_partner/app/widgets/sort_dropdown.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/modules/splash_screen/view/splash_screen_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/dingdong_3products_horiz/dingdong_3products_horiz_view.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';
import 'package:wholesaler_user/app/widgets/text_button.dart';

class Page1HomeView extends GetView<PartnerHomeController> {
  PartnerHomeController ctr = Get.put(PartnerHomeController());
  BottomNavbarController navbarCtr = Get.put(BottomNavbarController());
  init() {
    ctr.init();
  }
  double columnWidth = 0;
  @override
  Widget build(BuildContext context) {
    init();
    columnWidth = context.width / 3;
    return Obx(
      () =>ctr.isLoading.value ? LoadingWidget() :
      // ctr.isShowSplashScreen.isTrue
      //     ? SplashScreenPageView()
      //     :
      SingleChildScrollView(
              controller: ctr.scrollController.value,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    // Top Banner
                    _topBannerImage(),
                    SizedBox(height: 20),
                    _threeButtonsRow(),
                    SizedBox(height: 20),
                    Obx(
                      () => ctr.advertisements.isNotEmpty
                          ? Column(
                              children: [
                                Divider(color: Colors.black12),
                                SizedBox(height: 20),
                                _advertisementList(),
                              ],
                            )
                          : SizedBox.shrink(),
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: MyColors.grey3),
                      ),
                    ),
                    CacheProvider().isPrivilege()
                        ? _dingdongDelivery()
                        : SizedBox.shrink(),
                    SizedBox(height: 20),
                    _top10Products(),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: MyColors.grey3),
                      ),
                    ),
                    SizedBox(height: 20),
                    CacheProvider().isOwner() ? _payment() : SizedBox(),

                    _productList(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _threeButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          child: Text(
            '상품등록',
            style: MyTextStyles.f16,
          ),
          onPressed: () {
            Get.to(() => AddProductView());
          },
        ),
        SizedBox(width: 20),
        OutlinedButton(
          child: Text(
            '상품관리',
            style: MyTextStyles.f16,
          ),
          onPressed: () async {
            Get.put(ProductMgmtController()).isBottomNavbar.value = false;
            ProductMgmtController mgmtController =
                Get.put(ProductMgmtController());
            mgmtController.onInit();
            Get.to(() => ProductMgmtView(
                  isTop10Page: false,
                ));
          },
        ),
        SizedBox(width: 20),
        OutlinedButton(
          child: Text(
            '매출관리',
            style: MyTextStyles.f16,
          ),
          onPressed: () {
            Get.to(() => SalesMgmtView());
          },
        ),
      ],
    );
  }

  _topBannerImage() {
    return Obx(
      () => Container(
        width: Get.width,
        height: 400,
        decoration: BoxDecoration(color: MyColors.grey1),
        child: ((ctr.mainStoreInfo.value.mainTopImageUrl?.value.isNotEmpty ??
                false || ctr.isImagePicked.value)&&ctr.mainStoreInfo.value.mainTopImageUrl != null)
            ? _image()
            : _imageIcon(),
      ),
    );
  }

  Widget _image() {
    return Stack(children: [
      Obx(
        () => CachedNetworkImage(
          imageUrl: ctr.mainStoreInfo.value.mainTopImageUrl!.value,
          height: 400,
          width: Get.width,
          fit: BoxFit.fitHeight,
          // placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      if (ctr.isLoadingImage.value) LoadingWidget(),
      _TopBannerImageEditBtnBuilder(),
    ]);
  }

  _TopBannerImageEditBtnBuilder() {
    return Positioned(
      right: 5,
      top: 5,
      child: GestureDetector(
        onTap: () {
          ctr.uploadImageBtnPressed();
        },
        child: Container(
          decoration: BoxDecoration(
              color: MyColors.black,
              borderRadius:
                  BorderRadius.all(Radius.circular(MyDimensions.radius))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '상단배너 수정',
              style: TextStyle(color: MyColors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageIcon() {
    return GestureDetector(
      onTap: () async {
        ctr.uploadImageBtnPressed();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/ic_image_icon_gray.png'),
          Text('register_top_banner'.tr),
          Text('이미지에 최적화 되어있습니다.'),
          if (ctr.isLoadingImage.value) LoadingWidget(),
        ],
      ),
    );
  }

  _dingdongDelivery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 띵동배송
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'dingdongDelivery'.tr,
                style: MyTextStyles.f16,
              ),
              Spacer(),
              mTextButton.icon(
                text: 'View_more'.tr,
                icon: Icons.keyboard_arrow_right_outlined,
                onPressed: () {
                  Get.to(() => DingdongDeliveryView());
                },
              ),
            ],
          ),
        ),
        Dingdong3ProductsHorizView(),
      ],
    );
  }

  _top10Products() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 우리매장 베스트
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'our_store_best'.tr,
                style: MyTextStyles.f16,
              ),
              Spacer(),
              mTextButton.icon(
                text: 'manage'.tr,
                icon: Icons.keyboard_arrow_right_outlined,
                onPressed: () {
                  Get.to(() => Top10ProductsView());
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            height: 240,
            child: Obx(
              () => ctr.bestProducts.isNotEmpty
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: ctr.bestProducts.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 14),
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 105,
                          child: ProductItemVertical(
                            product: ctr.bestProducts.elementAt(index),
                            productNumber: ProductNumber(
                              number: index + 1,
                              backgroundColor:
                                  MyColors.numberColors.length > index
                                      ? MyColors.numberColors[index]
                                      : MyColors.numberColors[0],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: Text('제품을 등록해주세요.')),
            ),
          ),
        ),
      ],
    );
  }

  _payment() {
    return // Payment
        Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Settlement_mgmt'.tr,
                style: MyTextStyles.f16,
              ),
              Spacer(),
              mTextButton.icon(
                text: 'View_more'.tr,
                icon: Icons.keyboard_arrow_right_outlined,
                onPressed: () {
                  Get.to(() => PaymentView());
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 13),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '정산금액',
                style: MyTextStyles.f16,
              ),
              Spacer(),
              Obx(
                () => Text(
                  ctr.mainStoreInfo.value.settlementAmount != null
                      ? Utils.numberFormat(
                          number: ctr.mainStoreInfo.value.settlementAmount!,
                          suffix: '원')
                      : '',
                  style: MyTextStyles.f18_bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 10,
          child: DecoratedBox(
            decoration: BoxDecoration(color: MyColors.grey3),
          ),
        ),
      ],
    );
  }

  _productList() {
    return // 전체상품
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '전체상품',
                style: MyTextStyles.f16,
              ),
              Spacer(),
              // Sort Dropdown 최신순 , 판매순
              Obx(
                () => SortDropDown(
                  items: [
                    SortProductDropDownItem.latest,
                    SortProductDropDownItem.bySales
                  ],
                  selectedItem: ctr.selectedSortProductDropDownItem.value,
                  onPressed: (selectedItem) =>
                      ctr.sortDropDownChanged(selectedItem),
                ),
              ),
            ],
          ),
          // Search Field
          SearchField(
            hint: '상품명 검색',
            controller: ctr.searchController,
            onSubmitted: (searchText) =>
                ctr.callGetProductsAPI(searchContent: searchText),
          ),
          SizedBox(height: 10),
          ProductGridViewBuilder(
            crossAxisCount: 3,
            productHeight: 300,
            products: ctr.products,
            isShowLoadingCircle: ctr.allowCallAPI,
          ),
        ],
      ),
    );
  }

  _advertisementList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '광고',
                style: MyTextStyles.f16,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            height: 480,
            child: Obx(
              () =>
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: ctr.advertisements.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AdvertisementItemVertical(
                        advertisement: ctr.advertisements.elementAt(index),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      childAspectRatio: columnWidth /
                          (MyVars.isSmallPhone()
                              ? 270
                              : 260), // explanation: add productheight +10 for small screen sizes, if we don't, on small screen the product height is too short
                    ),
                  ),
              //     ListView.separated(
              //   scrollDirection: Axis.horizontal,
              //   shrinkWrap: true,
              //   itemCount: ctr.advertisements.length,
              //   separatorBuilder: (BuildContext context, int index) =>
              //       SizedBox(width: 20),
              //   itemBuilder: (BuildContext context, int index) {
              //     return SizedBox(
              //       width: 105,
              //       child: AdvertisementItemVertical(
              //         advertisement: ctr.advertisements.elementAt(index),
              //       ),
              //     );
              //   },
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
