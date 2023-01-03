import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_4_controller.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/modules/auth/register_privacy_terms/views/register_privacy_terms_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';

import '../controllers/register_ceo_employee_1_controller.dart';

class RegisterCeoEmployeePage4View
    extends GetView<RegisterCeoEmployee4Controller> {
  RegisterCeoEmployee4Controller ctr =
      Get.put(RegisterCeoEmployee4Controller());

  RegisterCeoEmployee1Controller registerCeoEmployeeCtr =
      Get.put(RegisterCeoEmployee1Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        isBackEnable: true,
        title:
            '회원가입 (${registerCeoEmployeeCtr.isEmployee.value ? '직원' : '대표'})',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 102),
              Center(
                child: Container(
                  height: 63,
                  width: 63,
                  child: Image.asset('assets/icons/ic_check.png'),
                ),
              ),
              SizedBox(height: 79),
              // Phone Number - 핸드폰 번호

              CustomField(
                fieldLabel: 'phone_number'.tr,
                fieldText: '휴대폰 번호를 입력해주세요.',
                fieldController: ctr.phoneNumCtr,
                onTap: () {
                  ctr.requestVerifyPhonePressed();
                },
                isTextKeyboard: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                ],
                buttonText: 'verify'.tr,
                fontSize: 12,
              ),

              SizedBox(height: 16),
              // Verification number - 인증번호 입력

              CustomField(
                fieldLabel: 'input_verification_num'.tr,
                fieldText: '인증번호를 입력해주세요.',
                fieldController: ctr.phoneNumVerifyCtr,
                isTextKeyboard: true,
                onTap: () {
                  ctr.verifyPhonePressed();
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                ],
                buttonText: 'ok'.tr,
              ),

              SizedBox(height: 15),
              // Accept all checkbox
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: MyColors.primary,
                      value: ctr.isAgreeAll.value,
                      onChanged: (value) {
                        ctr.isAgreeAll.value = value!;
                        ctr.isAgreeCondition.value = ctr.isAgreeAll.value;
                        ctr.isAgreePrivacy.value = ctr.isAgreeAll.value;
                      },
                    ),
                  ),
                  Text('agree_all'.tr),
                ],
              ),
              Divider(),
              // Terms checkbox
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: ctr.isAgreeCondition.value,
                      activeColor: MyColors.primary,
                      onChanged: (value) {
                        ctr.isAgreeCondition.value = value!;
                        if (ctr.isAgreeCondition.value &&
                            ctr.isAgreePrivacy.value) {
                          ctr.isAgreeAll.value = true;
                        } else {
                          ctr.isAgreeAll.value = false;
                        }
                      },
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Get.to(() => User_RegisterPrivacyTermsView(),
                            arguments: PrivacyOrTerms.terms.index);
                      },
                      icon: Text(
                        'Accept_terms'.tr,
                        style: TextStyle(color: MyColors.black),
                      ),
                      label: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: MyColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Privacy checkbox
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: ctr.isAgreePrivacy.value,
                      activeColor: MyColors.primary,
                      onChanged: (value) {
                        ctr.isAgreePrivacy.value = value!;
                        if (ctr.isAgreeCondition.value &&
                            ctr.isAgreePrivacy.value) {
                          ctr.isAgreeAll.value = true;
                        } else {
                          ctr.isAgreeAll.value = false;
                        }
                      },
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Get.to(() => User_RegisterPrivacyTermsView(),
                            arguments: PrivacyOrTerms.privacy.index);
                      },
                      icon: Text(
                        'privacy_policy'.tr,
                        style: TextStyle(color: MyColors.black),
                      ),
                      label: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: MyColors.black,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      onPressed: () {
                        registerCeoEmployeeCtr.isEmployee.value
                            ? ctr.employeeRegisterBtnPressed()
                            : ctr.registerBtnPressed();
                      },
                      text: 'sign_up'.tr,
                    ),
                  )),
              // SizedBox(height: 15),
              // Center(child: Text('Email_inquiry'.tr)),
              // Center(
              //   child: Container(
              //     width: 100,
              //     height: 1,
              //     decoration: BoxDecoration(
              //       border: Border(
              //         bottom: BorderSide(color: Colors.grey),
              //       ),
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
