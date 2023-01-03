

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/modules/ad/controllers/ad_controller.dart';
import 'package:wholesaler_partner/app/modules/ad/views/ad_view.dart';
import 'package:wholesaler_partner/app/modules/ad_impression/views/ad_impression_view.dart';
import 'package:wholesaler_partner/app/modules/business_license/view/business_view.dart';
import 'package:wholesaler_partner/app/modules/business_name/controller/business_name_controller.dart';
import 'package:wholesaler_partner/app/modules/business_name/view/business_name_view.dart';
import 'package:wholesaler_partner/app/modules/customer_center/view/customer_center_view.dart';
import 'package:wholesaler_partner/app/modules/employee_mgmt/views/employee_mgmt_view.dart';
import 'package:wholesaler_partner/app/modules/main/controller/partner_main_controller.dart';
import 'package:wholesaler_partner/app/modules/main/view/partner_main_view.dart';
import 'package:wholesaler_partner/app/modules/my_bank_account_mgmt/views/my_bank_account_mgmt_view.dart';
import 'package:wholesaler_partner/app/modules/page1_home/controller/partner_home_controller.dart';
import 'package:wholesaler_partner/app/modules/page1_home/view/page1_home_view.dart';
import 'package:wholesaler_partner/app/modules/page2_order_history/controllers/page2_order_history_controller.dart';
import 'package:wholesaler_partner/app/modules/page2_order_history/views/page2_order_history_view.dart';
import 'package:wholesaler_partner/app/modules/page3_my_info_mgmt/views/my_info_mgmt_view.dart';
import 'package:wholesaler_partner/app/modules/page3_my_page/controllers/page3_my_page_controller.dart';
import 'package:wholesaler_partner/app/modules/payment/views/payment_view.dart';
import 'package:wholesaler_partner/app/modules/product_inquiry_list/view/product_inquiry_list_view.dart';
import 'package:wholesaler_partner/app/modules/top_10_products/controllers/top_10_products_controller.dart';
import 'package:wholesaler_partner/app/modules/top_10_products/views/top_10_products_view.dart';
import 'package:wholesaler_partner/app/widgets/bottom_navbar/bottom_navbar_controller.dart';
import 'package:wholesaler_partner/app/widgets/my_page_item.dart';
import 'package:wholesaler_partner/app/widgets/two_text_container_widget.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/functions.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/modules/auth/register_privacy_terms/views/register_privacy_terms_view.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/bulletin_list/views/bulletin_list_view.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/modules/review_list/views/review_list_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wholesaler_user/app/modules/splash_screen/controller/splash_screen_controller.dart';
import 'package:wholesaler_user/app/widgets/dingdong_3products_horiz/dingdong_3products_horiz_controller.dart';
import '../../../widgets/loading_widget.dart';
import '../../employee_mgmt/controllers/employee_mgmt_controller.dart';
import '../../my_bank_account_mgmt/controllers/my_bank_account_mgmt_controller.dart';
import '../../page3_my_info_mgmt/controllers/my_info_mgmt_controller.dart';
import '../../product_inquiry_list/controller/product_inquiry_list_controller.dart';
import '../../product_inquiry_list/view/product_inquiry_list_view.dart';

class Page3MyPageView extends GetView<Page3MyPageController> {
  Page3MyPageController ctr = Get.put(Page3MyPageController());
  @override
  Widget build(BuildContext context) {
    ctr.getUserInfo();
    return Obx(() {
      return ctr.isLoading.value
          ? LoadingWidget()
      : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _headerStore(),
                  SizedBox(height: 14),
                  // Like, Total products, manage my info
                  _threeButtons(),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 6,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: MyColors.grey3),
              ),
            ),
            _itemList1(),
            SizedBox(
              width: double.infinity,
              height: 6,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: MyColors.grey3),
              ),
            ),
            _itemList2(),
            SizedBox(
              width: double.infinity,
              height: 6,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: MyColors.grey3),
              ),
            ),
            _itemList3(),
            SizedBox(height: 18),
            _kakaoChannel(),
            SizedBox(height: 22),
            _logoutButton(),
            SizedBox(height: 22),
            _withdrawButton(),
            SizedBox(height: 67),
          ],
        ),
      );
    });
  }

  _headerStore() {
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          child: ctr.store.imgUrl == null ||
                  ctr.store.imgUrl != null && ctr.store.imgUrl == ''
              ? CircleAvatar(
                  backgroundColor: MyColors.grey1,
                  child: Icon(
                    Icons.store,
                    color: MyColors.black,
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: ctr.store.imgUrl!.value,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  // placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
        ),
        SizedBox(width: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ctr.storeName.value!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 6),
                Text(
                  ctr.accountId.toString(),
                  style: TextStyle(color: Colors.black38),
                ),
              ],
            ),
            SizedBox(width: 10),
            ctr.isOwner ? Text('CEO'.tr) : Text('employee'.tr),
          ],
        ),
      ],
    );
  }

  _threeButtons() {
    return ctr.isLoading.value
        ? LoadingWidget()
        : Row(
            children: [
              Expanded(
                  child: TwoTextContainer(
                      topText: 'number_of_likes'.tr,
                      bottomText: ctr.store.totalStoreLiked.toString() + '회')),
              SizedBox(width: 20),
              Expanded(
                  child: TwoTextContainer(
                      topText: 'All_products'.tr,
                      bottomText: ctr.store.totalProducts.toString())),
              SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.delete<MyInfoMgmtController>();
                      Get.to(() => MyInfoMgmtView());
                    },
                    child: Text(
                      '내 정보 관리',
                      style: MyTextStyles.f12.copyWith(color: MyColors.black2),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.grey1,
                      elevation: 0,
                    ),
                  ),
                ),
              )
            ],
          );
  }

  _itemList1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyPageItem(
          title: 'advertising_center'.tr,
          onPressed: () {
            Get.delete<AdController>();
            Get.to(() => AdView(), arguments: AdTabs.Tab1AdStatus.index);
          },
        ),
        Divider(),
        MyPageItem(
          title: 'shopping_ed'.tr,
          onPressed: () {
            Get.to(() => AdImpressionView());
          },
        ),
        // only show this column to isOwner
        ctr.isOwner
            ? Column(
                children: [
                  Divider(),
                  MyPageItem(
                    title: 'settlement'.tr,
                    onPressed: () {
                      Get.to(() => PaymentView());
                    },
                  ),
                  Divider(),
                  MyPageItem(
                    title: 'manage_my_bank'.tr,
                    onPressed: () {
                      Get.delete<MyBankAccountMgmtController>();
                      Get.to(() => MyBankAccountMgmtView());
                    },
                  ),
                  Divider(),
                  MyPageItem(
                    title: 'verify_business_register_doc'.tr,
                    onPressed: () {
                      Get.to(() => BusinessView());
                    },
                  ),
                  Divider(),
                  MyPageItem(
                    title: '상호수정',
                    onPressed: () {
                      Get.to(()=>BusinessInfo());
                    },
                  ),
                  Divider(),
                  MyPageItem(
                    title: '직원관리',
                    onPressed: () {
                      Get.delete<EmployeeMgmtController>();
                      Get.to(() => EmployeeMgmtView());
                    },
                  ),
                ],
              )
            : SizedBox(),
      ],
    );
  }

  _itemList2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyPageItem(
          title: '우리매장 TOP10',
          onPressed: () {
            Get.delete<Top10ProductsController>();
            Get.to(() => Top10ProductsView());
          },
        ),
        Divider(),
        MyPageItem(
          title: 'product_inquiry'.tr,
          onPressed: () {
            Get.delete<ProductInquiryListController>();
            Get.to(() => ProductInquiryListView());
          },
        ),
        Divider(),
        MyPageItem(
          title: 'review'.tr,
          onPressed: () {
            Get.to(() => ReviewListView());
          },
        ),
        Divider(),
        MyPageItem(
          title: 'bulletin'.tr,
          onPressed: () {
            Get.to(() => BulletinListView());
          },
        ),
      ],
    );
  }

  _itemList3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyPageItem(
          title: 'customer_center'.tr,
          onPressed: () {
            Get.to(() => CustomerCenterView(isWithdrawPage: false));
          },
        ),
        Divider(),
        MyPageItem(
          title: 'privacy_terms'.tr,
          onPressed: () {
            Get.to(() => User_RegisterPrivacyTermsView());
          },
        ),
        Divider(),
      ],
    );
  }

  _kakaoChannel() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            launch("http://pf.kakao.com/_SIjhxj");
          },
          icon: Image.asset('assets/icons/ic_kakao_channel.png'),
        ),
      ),
    );
  }

  _logoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            print("로그아웃");
            // CacheProvider().removeOwner();
            CacheProvider().removeFCMToken();
            CacheProvider().removeToken();
            CacheProvider().removeUserId();
            // Get.delete<Page1HomeController>();
            // Get.delete<Page3MyPageController>();
            // Get.delete<Page2OrderHistoryView>();
            await Get.deleteAll();
            //await Get.reset();
            await Get.off(() => User_LoginPageView());
            print("============${CacheProvider().getUserID()}");
            //Get.offAllNamed('/login');



          },
          child: Text(
            'logout'.tr,
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            primary: MyColors.grey4,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  _withdrawButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => CustomerCenterView(isWithdrawPage: true));
          },
          child: Text(
            '탈퇴 요청',
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            primary: MyColors.grey4,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
