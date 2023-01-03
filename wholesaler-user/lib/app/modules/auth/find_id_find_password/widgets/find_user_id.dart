import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/modules/auth/find_id_find_password/controllers/find_user_id_controller.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/main/controllers/user_main_controller.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_view.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

class Tab1FindUserIdView extends GetView<User_FindID_FindPasswordController> {
  User_FindID_FindPasswordController ctr =
      Get.put(User_FindID_FindPasswordController());
  Tab1FindUserIdView();
  UserMainController u =Get.put(UserMainController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            PhoneNumberPhoneVerify(
              spaceBetween: 10,
            ),
            SizedBox(
              height: 30,
            ),
            TwoButtons(
              leftBtnText: '취소',
              lBtnOnPressed: () {
                Get.offAll(() => User_LoginPageView());
              },
              rightBtnText: '아이디 찾기',
              rBtnOnPressed: ctr.getAccountId,
            )
          ],
        ),
      ),
    );
  }
}
