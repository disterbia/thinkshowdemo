import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/constants/variables.dart';

import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';

import '../../../../models/status_model.dart';
import '../../../../widgets/snackbar.dart';

class PasswordResetController extends GetxController {
  pApiProvider partnerApiProvider = pApiProvider();
  uApiProvider userApiProvider = uApiProvider();

  var arguments = Get.arguments;

  late TextEditingController passwordController;
  late TextEditingController rePasswordController;

  RxBool isLoading = false.obs;

  int certifyId = 0;
  String accountId = '';

  @override
  void onInit() {
    super.onInit();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    certifyId = arguments[0];
    accountId = arguments[1];
  }

  @override
  void dispose() {
    super.dispose();
    rePasswordController.dispose();
    passwordController.dispose();
  }

  Future<void> resetPassword() async {
    if (passwordController.text.isEmpty) {
      mSnackbar(message: '비밀번호를 입력해주세요.');
      return;
    }
    if (rePasswordController.text.isEmpty) {
      mSnackbar(message: '비밀번호 확인을 입력해주세요.');
      return;
    }

    isLoading.value = true;

    StatusModel statusModel;

    if (MyVars.isUserProject()) {
      statusModel = await userApiProvider.resetPassword(data: {
        'certifi_id': certifyId,
        'account_id': accountId,
        'password': rePasswordController.text.toString(),
        're_password': passwordController.text.toString(),
      });
    } else {
      statusModel = await partnerApiProvider.resetPassword(data: {
        'certifi_id': certifyId,
        'account_id': accountId,
        'password': rePasswordController.text.toString(),
        're_password': passwordController.text.toString(),
      });
    }

    isLoading.value = false;

    if (statusModel.statusCode == 200) {
      Get.to(User_LoginPageView());
    } else {
      mSnackbar(message: statusModel.message);
    }
  }
}
