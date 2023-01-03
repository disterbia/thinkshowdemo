import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/functions.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class MyPageUpdatePasswordController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();
  TextEditingController originalPasswordCtr = TextEditingController();
  TextEditingController newPasswordCtr = TextEditingController();
  TextEditingController newPasswordVerifyCtr = TextEditingController();

  changePasswordPressed() async {
    //print('change password pressed');
    // check if empty
    if (originalPasswordCtr.text.isEmpty || newPasswordCtr.text.isEmpty || newPasswordVerifyCtr.text.isEmpty) {
      mSnackbar(message: '모든 항목을 입력해주세요.');
      return;
    }

    // check if same
    if (newPasswordCtr.text != newPasswordVerifyCtr.text) {
      mSnackbar(message: '새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.');
      return;
    }

    bool isSuccess = await _apiProvider.changePassword(
      originalPassword: originalPasswordCtr.text,
      newPassword: newPasswordCtr.text,
      newPasswordVerify: newPasswordVerifyCtr.text,
    );
    if (isSuccess) {
      mSnackbar(message: '비밀번호 변경 완료 되었습니다.');
      mFuctions.userLogout();
    } else {
      mSnackbar(message: '비밀번호 변경 실패 되었습니다.');
    }
  }
}
