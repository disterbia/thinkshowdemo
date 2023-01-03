// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/Constants/functions.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/bulletin_list/views/bulletin_list_view.dart';
import 'package:wholesaler_user/app/modules/faq/views/faq_view.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/orders_inquiry_review_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/order_inquiry_and_review_view.dart';
import 'package:wholesaler_user/app/modules/page4_favorite_products/controllers/page4_favorite_products_controller.dart';
import 'package:wholesaler_user/app/modules/page4_favorite_products/views/page4_favorite_products_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/company_intro_page/view/company_intro_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/controllers/page5_my_page_controller.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/inquiries_page/view/inquiries_page_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/widgets/top_user_id_name_widget.dart';
import 'package:wholesaler_user/app/modules/point_mgmt/views/point_mgmt_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class Page5MyPageView extends GetView<Page5MyPageController> {
  late Page5MyPageController ctr;
  Page5MyPageView();

  init() {
    ctr = Get.put(Page5MyPageController());
    ctr.init();
  }

  @override
  Widget build(BuildContext context) {
   // print('inside Page5MyPageView build');
    init();
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: false, title: '마이페이지'),
      body: Obx(()=>ctr.isLoading.value?LoadingWidget(): _body()),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _userIdUsername(),
          _topThreeVerticalBoxs(),
          SizedBox(height: 20),
          Divider(thickness: 6, color: MyColors.grey3),
          _settingOption('최근 본 상품', () {
            Get.delete<Page4Favorite_RecentlyViewedController>();
            Get.to(() => Page4FavoriteProductsView(isRecentSeenProduct: true));
          }),
          Divider(color: MyColors.grey3),
          _settingOption('문의내역', () {
            Get.to(() => InquiriesPageView());
          }),
          Divider(color: MyColors.grey3),
          _settingOption('FAQ', () {
            Get.to(() => FaqView());
          }),
          Divider(color: MyColors.grey3),
          _settingOption('공지사항', () {
            Get.to(() => BulletinListView());
          }),
          Divider(color: MyColors.grey3),
          _settingOption('회사 소개', () {
            Get.to(() => CompanyIntroPageView());
          }),
          Divider(color: MyColors.grey3),
          _settingOption('로그아웃', () {
            mFuctions.userLogout();
          }),
        ],
      ),
    );
  }

  Widget _userIdUsername() {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(
          () => TopUserIDUserNameSettings(
            user: ctr.user.value,
            showSettingsIcon: true,
          ),
        ));
  }

  Widget _topThreeVerticalBoxs() {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        _settingBox('주문조회', null, () {
          Get.delete<OrderInquiryAndReviewController>();

          Get.to(
              () => OrderInquiryAndReviewView(
                  isBackEnable: true, hasHomeButton: false),
              arguments: false);
        }),
        SizedBox(
          width: 10,
        ),
        _settingBox(
            '리뷰',
            ctr.user.value.waitingReviewCount != null
                ? ctr.user.value.waitingReviewCount.toString()
                : '0', () {
          Get.delete<OrderInquiryAndReviewController>();
          Get.to(
              () => OrderInquiryAndReviewView(
                  isBackEnable: true, hasHomeButton: false),
              arguments: true);
        }),
        SizedBox(
          width: 10,
        ),
        Obx(() => ctr.user.value.points != null
            ? _settingBox(
                '내 포인트',
                Utils.numberFormat(number: ctr.user.value.points!.value),
                () => Get.to(
                  () => PointMgmtView(),
                ),
              )
            : Container()),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _settingOption(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
        width: double.infinity,
        child: Text(
          title,
          style: MyTextStyles.f16.copyWith(color: MyColors.black3),
        ),
      ),
    );
  }

  Widget _settingBox(String label, String? value, Function() onTap) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(MyDimensions.radius)),
              border: Border.all(color: MyColors.grey1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                label,
                style: MyTextStyles.f16,
              )),
              value != null
                  ? Center(
                      child: Text(
                        value,
                        style: MyTextStyles.f16,
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
