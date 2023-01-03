import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/change_number/controller/change_number_controller.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_view.dart';

class ChangeNumberView extends StatelessWidget {
  ChangeNumberController ctr = Get.put(ChangeNumberController());
  ChangeNumberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ctr.phoneNumberPhoneVerifyController.numberController.text = "";
    ctr.phoneNumberPhoneVerifyController.numberVerifyController.text = "";
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  Widget _body() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 35),
            child: PhoneNumberPhoneVerify(
              spaceBetween: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomButton(
              width: Get.width,
              onPressed: () => ctr.editBtnPressed(),
              text: '수정',
            ),
          )
        ],
      );

  AppBar _appbar() {
    return CustomAppbar(isBackEnable: true, title: '휴대폰번호 변경', actions: [
      Icon(
        Icons.search,
        color: Colors.black,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.black,
        ),
      )
    ]);
  }
}
