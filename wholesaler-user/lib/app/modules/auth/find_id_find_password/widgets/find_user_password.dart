import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/modules/auth/password_reset/view/password_reset_view.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/auth/user_password_result/controller/find_user_password_controller.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_controller.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_view.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

import '../controllers/find_user_id_controller.dart';

class Tab2FindUserPasswordView extends GetView<User_FindID_FindPasswordController> {
  User_FindID_FindPasswordController ctr = Get.put(User_FindID_FindPasswordController());
  PhoneNumberPhoneVerifyController phoneNumberPhoneVerifyController = Get.put(PhoneNumberPhoneVerifyController());
  Tab2FindUserPasswordView();

  init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      phoneNumberPhoneVerifyController.numberVerifyController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Obx(() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomField(fieldLabel: '아이디', fieldText: '아이디 입력해주세요', fieldController: ctr.idController),
              _space(),
              PhoneNumberPhoneVerify(
                spaceBetween: 10,
              ),
              _space(),
              TwoButtons(
                  isLoadingRight: ctr.isLoading.value,
                  leftBtnText: '취소',
                  lBtnOnPressed: () {
                    Get.to(() => User_LoginPageView());
                  },
                  rightBtnText: '비밀번호 찾기',
                  rBtnOnPressed: ctr.findPassword),
            ],
          ),
        ),
      );
    });
  }

  Widget _space() => SizedBox(
        height: 10,
      );
}
