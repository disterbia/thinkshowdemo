// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/change_number/view/change_number_view.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/Constants/functions.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/auth/register_privacy_terms/views/register_privacy_terms_view.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/auth/user_sign_up/controllers/user_sign_up_controller.dart';
import 'package:wholesaler_user/app/modules/auth/user_sign_up/views/user_sign_up_view.dart';
import 'package:wholesaler_user/app/modules/my_page_update_password/views/my_page_update_password_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/controllers/page5_my_page_controller.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/views/my_page_down.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/widgets/top_user_id_name_widget.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/dialog.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

class MyPageSettingsView extends GetView<Page5MyPageController> {
  Page5MyPageController ctr = Get.put(Page5MyPageController());

  MyPageSettingsView();
  int myTest=0;
  @override
  Widget build(BuildContext context) {
   myTest=0;
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: true, title: 'My_page'.tr),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() => Column(
        children: [
          GestureDetector(onDoubleTap:() {
            myTest++;
            if(myTest==20){
              Get.to(()=>MyPageDown());
            }
          }, child: _userId()),
          Divider(thickness: 6, color: MyColors.grey3),
          _settingOption('회원정보수정', () {
            Get.put(SignupOrEditController()).isEditing.value = true;
            Get.to(() => User_SignUpView());
          }),
          Divider(color: MyColors.grey3),
          _settingOption('휴대폰번호 변경 ', () {
            Get.to(() => ChangeNumberView());
          }),
          Divider(color: MyColors.grey3),
          _settingOption('비밀번호 변경', () => Get.to(() => MyPageUpdatePasswordView())),
          Divider(thickness: 6, color: MyColors.grey3),
          _switch(),
          Divider(thickness: 6, color: MyColors.grey3),
          _settingOption('terms'.tr, () => Get.to(() => User_RegisterPrivacyTermsView(), arguments: PrivacyOrTerms.terms)),
          Divider(color: MyColors.grey3),
          _settingOption('privacy_policy'.tr, () => Get.to(() => User_RegisterPrivacyTermsView(), arguments: PrivacyOrTerms.privacy)),
          Divider(color: MyColors.grey3),
          Spacer(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: CustomButton(
          //     text: '로그아웃',
          //     fontSize: 14,
          //     textColor: MyColors.black1,
          //     onPressed: () => mFuctions.userLogout(),
          //     backgroundColor: MyColors.grey1,
          //     borderColor: Colors.transparent,
          //     width: double.infinity,
          //   ),
          // ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              text: '탈퇴',
              fontSize: 14,
              textColor: MyColors.black1,
              onPressed: () {
                mDialog(
                  title: '회원탈퇴를 원하십니까?',
                  subtitle: '모든 데이터가 삭제 됩니다.',
                  twoButtons: TwoButtons(
                    leftBtnText: 'cancel'.tr,
                    rightBtnText: 'delete_user_account'.tr,
                    lBtnOnPressed: () {
                      Get.back();
                    },
                    rBtnOnPressed: () => ctr.deleteuserAccountBtnPressed(),
                  ),
                );
              },
              backgroundColor: MyColors.grey1,
              borderColor: Colors.transparent,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 20),
        ],
      );

  Widget _switch() {
    return Obx(
      () => ListTile(
        title: Text('event_marketing_alarm'.tr),
        trailing: Switch(value: ctr.user.value.isAgreeNotificaiton!.value, onChanged: (value) => ctr.notificationToggled(value)),
      ),
    );
  }

  Widget _settingOption(String title, Function() onTap) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
    );
  }

  Widget _userId() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TopUserIDUserNameSettings(user: ctr.user.value, showSettingsIcon: false),
    );
  }
}
