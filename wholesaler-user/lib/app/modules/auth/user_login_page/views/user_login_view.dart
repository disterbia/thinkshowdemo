import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/main/view/partner_main_view.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/views/register_ceo_employee_1_view.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/images.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/modules/auth/find_id_find_password/views/find_id_find_password_view.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/controllers/login_controller.dart';
import 'package:wholesaler_user/app/modules/auth/user_sign_up/views/user_sign_up_view.dart';
import 'package:wholesaler_user/app/modules/main/view/user_main_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_field.dart';

class User_LoginPageView extends GetView<User_LoginPageController> {
  User_LoginPageController ctr = Get.put(User_LoginPageController());

  User_LoginPageView();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppbar(isBackEnable: true, title: ''),
        backgroundColor: MyColors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  _logo(),
                  _userField(),
                  _passwordField(),
                  ctr.isLoading.value ? LoadingWidget() : _loginButton(),
                  _findId_findPassword(),
                  _signUpButton(),
                  SizedBox(height: 20),
                  Obx(
                    () => Column(
                      children: [
                        Text('버전: ${ctr.appVersion}', style: MyTextStyles.f11),
                        Text('빌드: ${ctr.appBuild}', style: MyTextStyles.f11),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
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

  Widget _userField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextField(
        labelText: '아이디를 입력하세요.',
        controller: ctr.usernameController,
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextField(
        labelText: '비밀번호 입력',
        controller: ctr.passwordController,
        obscureText: true,
      ),
    );
  }

  Widget _loginButton() {
    //User_LoginPageController ctr = Get.put(User_LoginPageController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              
              ctr.loginBtnPressed();
            },
            child: Text(
              '로그인',
              style: MyTextStyles.f18.copyWith(color: Colors.white),
            )),
      ),
    );
  }

  Widget _findId_findPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Find ID Button
        TextButton(
          child: Text(
            '아이디 찾기',
            style: MyTextStyles.f14.copyWith(color: MyColors.black1),
          ),
          onPressed: () {
            Get.to(() => User_FindID_FindPasswordView(), arguments: FindIDPasswordTabIndex.findID.index);
          },
        ),
        // Find Password Button
        TextButton(
          child: Text(
            '비밀번호 찾기',
            style: MyTextStyles.f14.copyWith(color: MyColors.black1),
          ),
          onPressed: () {
            Get.to(() => User_FindID_FindPasswordView(), arguments: FindIDPasswordTabIndex.findPassword.index);
          },
        ),
      ],
    );
  }

  Widget _signUpButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            ctr.signUpBtnPressed();
          },
          child: Text(
            '회원가입',
            style: MyTextStyles.f18.copyWith(color: MyColors.grey8),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: MyColors.primary),
          ),
        ),
      ),
    );
  }
}
