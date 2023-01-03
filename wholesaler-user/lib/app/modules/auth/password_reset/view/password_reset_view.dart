import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/modules/auth/find_id_find_password/views/find_id_find_password_view.dart';
import 'package:wholesaler_user/app/modules/auth/password_reset/controller/password_reset_controller.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

// class PasswordResetView extends GetView<PasswordResetController> {
class PasswordResetView extends StatelessWidget {
  PasswordResetController ctr = Get.put(PasswordResetController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppbar(isBackEnable: true, title: '비밀번호 변경'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 40),
              CustomField(fieldLabel: '비밀번호 입력', fieldText: '새비밀번호 입력', fieldController: ctr.passwordController),
              _space(),
              CustomField(fieldLabel: '새비밀번호 입력 확인', fieldText: '새비밀번호를 확인해주세요', fieldController: ctr.rePasswordController),
              _space(),
              TwoButtons(
                  isLoadingRight: ctr.isLoading.value,
                  rightBtnText: '비밀번호 변경',
                  leftBtnText: '취소',
                  rBtnOnPressed: ctr.resetPassword,
                  lBtnOnPressed: () {
                    Get.to(() => User_LoginPageView());
                  })
            ],
          ),
        ),
      );
    });
  }

  Widget _space() {
    return const SizedBox(
      height: 10,
    );
  }
}
