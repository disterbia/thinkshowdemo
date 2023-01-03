import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_1_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/views/register_ceo_employee_4_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../business_registration_submit/controllers/business_registration_submit_controller.dart';

class RegisterCeoEmployee3Controller extends GetxController {
  RegisterCeoEmployee1Controller register1Ctr =
      Get.put(RegisterCeoEmployee1Controller());

  TextEditingController companyNameCtr = TextEditingController();
  TextEditingController ceoNameCtr = TextEditingController();
  TextEditingController idCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController passwordVerifyCtr = TextEditingController();
  TextEditingController BusinessRegisterNumCtr = TextEditingController();

  pApiProvider apiProvider = pApiProvider();

  late bool _isIdDuplicated;

  @override
  void onInit() {
    super.onInit();
  }

  verifyIdPressed() async {
    if (isIdLengthCorrect()) {
      return;
    }
    apiProvider.getVerifyId(userId: idCtr.text).then((val) {
      _isIdDuplicated = val;
      if (_isIdDuplicated) {
        showDuplicatedIdError();
      } else {
        showIdSuccessfulSnackbar();
      }
    });
  }

  bool isIdLengthCorrect() {
    if (idCtr.text.length < 5 || idCtr.text.length > 20) {
      mSnackbar(message: '아이디는 최소 5자 최대 20자를 입력하세요.');
      return true;
    } else {
      return false;
    }
  }

  void showDuplicatedIdError() {
    mSnackbar(message: '이미 등록 된 아이디 입니다.');
  }

  void showIdSuccessfulSnackbar() {
    mSnackbar(message: '사용 가능한 아이디 입니다.');
  }

  void nextBtnPressed() {
    if (companyNameCtr.text.isEmpty && register1Ctr.isEmployee.isFalse) {
      mSnackbar(message: '상호명을 입력하세요.');
      return;
    }
    if (ceoNameCtr.text.isEmpty) {
      mSnackbar(message: '이름을 입력하세요.');
      return;
    }
    if (idCtr.text.length < 5 || idCtr.text.length > 20) {
      mSnackbar(message: '아이디는 최소 5자 최대 20자를 입력하세요.');
      return;
    }
    if (idCtr.text.isEmpty) {
      mSnackbar(message: '아이디를 입력하세요.');
      return;
    }
    if (passwordCtr.text.isEmpty) {
      mSnackbar(message: '비밀번호를 입력하세요.');
      return;
    }
    if (passwordCtr.text.length < 8) {
      mSnackbar(message: '비밀번호 8자 이상 입력해주세요.');
      return;
    }
    if (passwordVerifyCtr.text.isEmpty) {
      mSnackbar(message: '비밀번호 확인을 입력하세요.');
      return;
    }
    if (passwordCtr.text != passwordVerifyCtr.text) {
      mSnackbar(message: '암호가 일치하는지 확인하십시오.');
      return;
    }
    if (BusinessRegisterNumCtr.text.isEmpty &&
        register1Ctr.isEmployee.isFalse) {
      mSnackbar(message: '사업자등록번호를 입력하세요.');
      return;
    }
    if (BusinessRegisterNumCtr.text.length != 10 &&
        register1Ctr.isEmployee.isFalse) {
      mSnackbar(message: '사업자등록번호 10자리를 입력하세요.');
      return;
    }
    if (Get.find<BusinessRegistrationSubmitController>()
            .uploadedImageURL
            .isEmpty &&
        register1Ctr.isEmployee.isFalse) {
      mSnackbar(message: '사업자등록증 이미지를 업로드하세요.');
      return;
    }
    if (_isIdDuplicated) {
      showDuplicatedIdError();
      return;
    }
    Get.to(() => RegisterCeoEmployeePage4View());
  }
}
