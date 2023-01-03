import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/modules/auth/register_privacy_terms/controllers/register_privacy_terms_controller.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/web_view_widget.dart';

class User_RegisterPrivacyTermsView extends GetView {
  User_RegisterPrivacyTermsController ctr = Get.put(User_RegisterPrivacyTermsController());
  String privacy = MyVars.isUserProject() ? '${mConst.API_BASE_URL}/web/user/privacy-policy' : '${mConst.API_BASE_URL}/web/staff/privacy-policy';
  String terms = MyVars.isUserProject() ? '${mConst.API_BASE_URL}/web/user/term-use' : '${mConst.API_BASE_URL}/web/staff/term-use';

  @override
  Widget build(BuildContext context) {
    //print('Get.arguments ${Get.arguments}');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(isBackEnable: true, title: '이용약관 & 개인정보', hasHomeButton: false),
      body: DefaultTabController(
        length: 2, // length of tabs
        // initialIndex: Get.arguments == PrivacyOrTerms.privacy ? 1 : 0, // initial index of tabs
        initialIndex: Get.arguments == PrivacyOrTerms.privacy.index ? 1 : 0, // initial index of tabs
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: '이용약관'),
                  Tab(text: '개인정보취급방침'),
                ],
              ),
            ),
            Container(
              height: context.height - 190,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
              ),
              child: TabBarView(
                children: [
                  _paragraphContainer(terms),
                  _paragraphContainer(privacy),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _paragraphContainer(String url) {
    return Obx(
      () => ctr.isLoading.value
          ? LoadingWidget()
          : SingleChildScrollView(
              child: Container(
                height: Get.height,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: WebViewWidget(
                  url: url,
                ),
              ),
            ),
    );
  }
}
