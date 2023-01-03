import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/images.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';

class User_PasswordResultView extends StatelessWidget {
  User_PasswordResultView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(isBackEnable: true, title: '비밀번호 찾기'),
      body: Column(
        children: [
          _logo(),
          _space(),
          _centerText('고객님의 비밀번호 변경이 완료되었습니다.'),
          _space(),
          _space(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              width: Get.width,
              onPressed: () {
                Get.offAll(User_LoginPageView());
              },
              text: '로그인',
            ),
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
