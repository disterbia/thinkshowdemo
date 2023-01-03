import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_controller.dart';

class PhoneNumberPhoneVerify extends StatelessWidget {
  PhoneNumberPhoneVerifyController ctr =
      Get.put(PhoneNumberPhoneVerifyController());

  double spaceBetween;

  PhoneNumberPhoneVerify({required this.spaceBetween});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomField(
          isTextKeyboard: true,
          fieldLabel: 'phone_number'.tr,
          fieldText: '휴대폰 번호 입력',
          fieldController: ctr.numberController,
          buttonText: 'verify'.tr,
          onTap: () {
            ctr.verifyPhoneBtnPressed();
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(11),
            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
          ],
        ),
        SizedBox(height: spaceBetween),
        CustomField(
          isTextKeyboard: true,
          fieldLabel: '인증번호 입력',
          fieldText: '인증번호 입력',
          fieldController: ctr.numberVerifyController,
          buttonText: 'ok'.tr,
          onTap: () {
            ctr.verifyCodeBtnPressed();
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
          ],
        ),
      ],
    );
  }
}
