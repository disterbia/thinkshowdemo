import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class PhoneNumberPhoneVerifyController extends GetxController {
  TextEditingController numberController = TextEditingController();
  TextEditingController numberVerifyController = TextEditingController();
  pApiProvider apiProvider = pApiProvider();

  int certifyId = -1;
  bool isPhoneVerifyFinished = false;

  Future<void> verifyPhoneBtnPressed() async {
    log('verifyPhone');
    if (numberController.text.isEmpty) {
      mSnackbar(message: '휴대폰 번호를 입력하세요.');
      return;
    }
    // check if only number
    if (!numberController.text.contains(RegExp(r'^[0-9]*$'))) {
      mSnackbar(message: '휴대폰 번호는 숫자만 입력하세요.');
      return;
    }
    if (!numberController.text
        .contains(RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$'))) {
      mSnackbar(message: '올바른 휴대폰 번호를 입력하세요.');
      return;
    }
    certifyId = await apiProvider.postRequestVerifyPhoneNum(
        phoneNumber: numberController.text);
    log('certifi_id is $certifyId');
  }

  Future<void> verifyCodeBtnPressed() async {
    log('verifyCode');
    // check if only number
    if (!numberController.text.contains(RegExp(r'^[0-9]*$'))) {
      mSnackbar(message: '휴대폰 번호는 숫자만 입력하세요.');
      return;
    }
    isPhoneVerifyFinished = await apiProvider.putPhoneNumVerify(
        phoneNumber: numberController.text,
        phoneNumVerify: numberVerifyController.text,
        certifi_id: certifyId);
  }
}
