import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../../data/api_provider.dart';

class MyBankAccountMgmtController extends GetxController {
  //TODO: Implement MyBankAccountMgmtController

  pApiProvider apiProvider = pApiProvider();

  late TextEditingController bankController;
  late TextEditingController holderNameController;
  late TextEditingController accountController;

  RxBool isLoading = false.obs;
  RxString accountName = ''.obs;
  RxString accountOwnerName = ''.obs;
  RxString accountNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    bankController = TextEditingController();
    holderNameController = TextEditingController();
    accountController = TextEditingController();
    getAccountInfo();
  }

  @override
  void dispose() {
    super.dispose();
    bankController.dispose();
    holderNameController.dispose();
    accountController.dispose();
  }

  getAccountInfo() {
    isLoading.value = true;
    apiProvider.getAccountInfo().then((StatusModel response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.data.toString());
        accountName.value = json['account_name'] ?? '은행을 선택해주세요.';
        accountOwnerName.value = json['account_owner_name'] ?? '예금주를 입력해주세요.'; //holder name
        accountNumber.value = json['account_number'] ?? '계좌번호를 입력해주세요.';
      } else {
        mSnackbar(message: response.message);
      }

      isLoading.value = false;
    });
  }

  saveAccountInfo() {
    isLoading.value = true;
    apiProvider.saveAccountInfo({
      "account_name": bankController.text.isEmpty ? accountName.value : bankController.text,
      "account_owner_name": holderNameController.text.isEmpty ? accountOwnerName.value : holderNameController.text,
      "account_number": accountController.text.isEmpty ? accountNumber.value : accountController.text
    }).then((StatusModel response) {
      if (response.statusCode == 200) {
        getAccountInfo();
        mSnackbar(message: response.message);
      } else {
        mSnackbar(message: response.message);
      }

      isLoading.value = false;
    });
  }
}
