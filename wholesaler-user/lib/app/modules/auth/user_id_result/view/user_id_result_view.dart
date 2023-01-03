import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/images.dart';
import 'package:wholesaler_user/app/modules/auth/find_id_find_password/controllers/find_user_id_controller.dart';
import 'package:wholesaler_user/app/modules/auth/find_id_find_password/views/find_id_find_password_view.dart';
import 'package:wholesaler_user/app/modules/auth/user_id_result/controller/user_id_result_controller.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

class UserIdResultView extends GetView<UserIdResultController> {
  UserIdResultController ctr = Get.put(UserIdResultController());
  UserIdResultView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(isBackEnable: true, title: '아이디 찾기'),
      body: Column(
        children: [
          _space(),
          _logo(),
          _centerText('아이디 찾기가 완료 되었습니다.'),
          _space(),
          _centerText(ctr.userId.value),
          _space(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TwoButtons(
                rightBtnText: '비밀번호 찾기',
                leftBtnText: '로그인',
                rBtnOnPressed: () {
                  // Get.delete<User_FindID_FindPasswordController>(); // Delete controller in order to reset arguments: TabIndex.findPassword.index
                  Get.put(User_FindID_FindPasswordController()).initialIndex.value = FindIDPasswordTabIndex.findPassword.index;
                  Get.to(() => User_FindID_FindPasswordView());
                },
                lBtnOnPressed: () {
                  Get.to(() => User_LoginPageView(), arguments: FindIDPasswordTabIndex.findPassword.index);
                }),
          )
        ],
      ),
    );
  }

  Widget _space() {
    return SizedBox(
      height: 10,
    );
  }

  Widget _centerText(String text) {
    return Align(alignment: Alignment.center, child: Text(text));
  }

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Container(
        width: 188,
        height: 68,
        child: Image.asset(MyImages.logo),
      ),
    );
  }
}
