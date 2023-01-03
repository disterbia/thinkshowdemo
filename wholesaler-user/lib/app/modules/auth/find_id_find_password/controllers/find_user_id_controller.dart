import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_controller.dart';

import '../../../../models/status_model.dart';
import '../../../../widgets/snackbar.dart';
import '../../password_reset/controller/password_reset_controller.dart';
import '../../password_reset/view/password_reset_view.dart';
import '../../user_id_result/view/user_id_result_view.dart';

class User_FindID_FindPasswordController extends GetxController {
  PhoneNumberPhoneVerifyController phoneNumberPhoneVerifyCtr =
      Get.put(PhoneNumberPhoneVerifyController());

  pApiProvider partnerApiProvider = pApiProvider();
  uApiProvider userApiProvider = uApiProvider();

  var arguments = Get.arguments;

  late TextEditingController idController;

  RxBool isLoading = false.obs;

  RxInt initialIndex = 0.obs;

  List<Tab> userIdTabs = [Tab(text: '아이디 찾기'), Tab(text: '비밀번호 찾기')];

  @override
  void onInit() {
    super.onInit();
    idController = TextEditingController();
    if (arguments != null) {
      print(arguments);
     // idController.text=arguments["accountId"];
      try{
        initialIndex.value = arguments;
      }catch(e){
        //idController.text=arguments["accountId"];
      }

    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
  }

  Future<void> getAccountId() async {
    StatusModel statusModel;

    if (MyVars.isUserProject()) {
      statusModel = await userApiProvider.getAccountId(data: {
        'certifi_id': phoneNumberPhoneVerifyCtr.certifyId.toString(),
        'phone': phoneNumberPhoneVerifyCtr.numberController.text.toString()
      });
    } else {
      statusModel = await partnerApiProvider.getAccountId(data: {
        'certifi_id': phoneNumberPhoneVerifyCtr.certifyId.toString(),
        'phone': phoneNumberPhoneVerifyCtr.numberController.text.toString()
      });
    }

    print(statusModel.statusCode);
    if (statusModel.statusCode == 200) {
      Get.offAll(() => UserIdResultView(), arguments: [
        {"accountId": statusModel.message},
      ]);
    } else {
      mSnackbar(message: statusModel.message);
    }
  }

  Future<void> findPassword() async {
    if (idController.text.isEmpty) {
      mSnackbar(message: '아이디를 입력해주세요.');
      return;
    }

    isLoading.value = true;

    StatusModel statusModel;

    if (MyVars.isUserProject()) {
      statusModel = await userApiProvider.findPassword(data: {
        'certifi_id': phoneNumberPhoneVerifyCtr.certifyId.toString(),
        'account_id': idController.text.toString()
      });
    } else {
      statusModel = await partnerApiProvider.findPassword(data: {
        'certifi_id': phoneNumberPhoneVerifyCtr.certifyId.toString(),
        'account_id': idController.text.toString()
      });
    }

    isLoading.value = false;

    if (statusModel.statusCode == 200) {
      Get.delete<PasswordResetController>();
      Get.to(() => PasswordResetView(), arguments: [
        phoneNumberPhoneVerifyCtr.certifyId,
        idController.text.toString()
      ]);
    } else {
      mSnackbar(message: statusModel.message);
    }
  }
}
