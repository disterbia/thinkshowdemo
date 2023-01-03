import 'dart:developer';
import 'dart:math' as Math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/user_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class SignupOrEditController extends GetxController {
  PhoneNumberPhoneVerifyController phoneCtr =
      Get.put(PhoneNumberPhoneVerifyController());

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordVerifyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController numberVerifyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController birthdayYear = TextEditingController();
  // TextEditingController birthdayMonth = TextEditingController();
  // TextEditingController birthdayDay = TextEditingController();

  final uApiProvider _apiProvider = uApiProvider();

  /// [isEditing] true means the user is editing his infomation
  /// [isEditing] false means the user is signing up for new account
  RxBool isEditing = false.obs;
  RxBool isAgreeToAll = false.obs;
  RxBool firstConditions = false.obs;
  RxBool secondConditions = false.obs;
  bool isIdAvailable = false;

  Rx<User> user = User(userID: '-1', userName: 'userName').obs;

  Future<void> init() async {
    if (isEditing.isTrue) {
      user.value = await _apiProvider.getUserInfo();
      // set controller text values
      emailController.text = user.value.email!;
      nameController.text = user.value.userName;
      // address
      address1Controller.text = user.value.address!.zipCode;
      address2Controller.text = user.value.address!.address;
      address3Controller.text = user.value.address!.addressDetail;
      // birthday
      // birthdayDay.text = user.value.birthday!.day.toString();
      // birthdayMonth.text = user.value.birthday!.month.toString();
      // birthdayYear.text = user.value.birthday!.year.toString();
    }
  }

  Future<void> checkIdAvailableBtnPressed() async {
    log('entered id is: ' + idController.text);
    if (idController.text == '') {
      mSnackbar(message: 'ID를 입력하세요.');
      return;
    }
    isIdAvailable =
        await _apiProvider.getCheckIdAvailablity(userId: idController.text);
    log('isIdAvailable $isIdAvailable');
    mSnackbar(
        message:
            isIdAvailable ? '사용가능한 ID입니다.' : '사용 불가능한 ID입니다. 다른 ID를 입력하세요.');
  }

  Future<void> searchAddressBtnPressed() async {
    log('inside searchAddressBtnPressed');
    Kpostal? result = await Navigator.push(
        Get.context!, MaterialPageRoute(builder: (_) => KpostalView()));
    print(result?.address);
    if (result != null) {
      address1Controller.text = result.postCode;
      address2Controller.text = result.address;
    }
  }

  Future<void> saveOrEditBtnPressed() async {
    log('saveOrEditBtnPressed');
    if (idController.text == '' && isEditing.isFalse) {
      mSnackbar(message: '아이디를 입력하세요.');
      return;
    }
    if (passwordController.text == '' && isEditing.isFalse) {
      mSnackbar(message: '비밀번호를 입력하세요.');
      return;
    }
    if (passwordVerifyController.text == '' && isEditing.isFalse) {
      mSnackbar(message: '비밀번호 확인를 입력하세요.');
      return;
    }
    if (passwordController.text != passwordVerifyController.text &&
        isEditing.isFalse) {
      mSnackbar(message: '비밀번호를 확인하세요.');
      return;
    }
    if (passwordController.text.length < 8 && isEditing.isFalse) {
      mSnackbar(message: '비밀번호를 8자 이상으로 입력해주세요.');
      return;
    }
    if (nameController.text == '') {
      mSnackbar(message: '이름을 입력하세요.');
      return;
    }
    if (address1Controller.text == '' ||
        address2Controller.text == '' ||
        address3Controller.text == '') {
      mSnackbar(message: '주소를 확인하세요.');
      return;
    }
    if (phoneCtr.numberController == '' && isEditing.isFalse) {
      mSnackbar(message: '휴대폰 번호를 입력하세요.');
      return;
    }
    if (phoneCtr.certifyId == -1 && isEditing.isFalse) {
      mSnackbar(message: '휴대폰 번호를 인증하세요.');
      return;
    }
    // if (birthdayYear == '' || birthdayMonth == '' || birthdayDay == '' && isEditing.isFalse) {
    //   mSnackbar(message: '생일을 입력하세요.');
    // }
    if (isAgreeToAll.isFalse && isEditing.isFalse) {
      mSnackbar(message: '이용약관 및 개인정보취급방침에 동의해주세요.');
      return;
    }

    if (isEditing.isTrue) {
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text)) {
        mSnackbar(message: '이메일 주소가 잘못 되었습니다.');
        return;
      }

      bool isSuccess = await _apiProvider.putUserInfoEdit();
      if (isSuccess) {
        mSnackbar(message: '수정 완료되었습니다.');
        Get.back();
        return;
      } else {
        mSnackbar(message: '수정 실패하였습니다.');
        return;
      }
    } else {
      bool isSuccess = await _apiProvider.postUserSignUp();
      if (isSuccess) {
        mSnackbar(message: '회원가입 완료되었습니다.');
        Get.offAll(User_LoginPageView());
      }
    }
  }
}
