import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/modules/my_page_update_password/controllers/my_page_update_password_controller.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/custom_field.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';

class MyPageUpdatePasswordView extends GetView<MyPageUpdatePasswordController> {
  MyPageUpdatePasswordController ctr =
      Get.put(MyPageUpdatePasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: true, title: 'Change_Password'.tr),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomField(
                fieldLabel: 'Enter_old_password'.tr,
                fieldText: 'Enter_old_password'.tr,
                fieldController: ctr.originalPasswordCtr,
                isObscureText: true,
              ),
              SizedBox(height: 15),
              CustomField(
                fieldLabel: 'enter_password'.tr,
                fieldText: 'enter_new_password'.tr,
                fieldController: ctr.newPasswordCtr,
                isObscureText: true,
              ),
              SizedBox(height: 15),
              CustomField(
                fieldLabel: 'verify_new_password'.tr,
                fieldText: 'verify_new_password'.tr,
                fieldController: ctr.newPasswordVerifyCtr,
                isObscureText: true,
              ),
              Spacer(),
              CustomButton(
                onPressed: () => ctr.changePasswordPressed(),
                text: 'change'.tr,
                width: double.infinity,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
