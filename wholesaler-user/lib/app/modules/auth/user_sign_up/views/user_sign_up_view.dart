import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/auth/register_privacy_terms/views/register_privacy_terms_view.dart';
import 'package:wholesaler_user/app/modules/auth/user_sign_up/controllers/user_sign_up_controller.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/custom_field.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_view.dart';

class User_SignUpView extends GetView {
  SignupOrEditController ctr = Get.put(SignupOrEditController());
  User_SignUpView();

  init() {
    ctr.init();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(
          isBackEnable: true, title: ctr.isEditing.value ? '회원정보' : '회원가입'),
      body: _signUpBody(),
    );
  }

  Widget _signUpBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _idBuilder(),
            _emailBuilder(),
            SizedBox(height: 15),
            _passwordBuilder(),
            _nameBuilder(),
            SizedBox(height: 15),
            _addressBuilder(),
            // address search
            SizedBox(height: 15),
            _phoneNumberPhoneVerifyBuilder(),
            // _birthdayBuilder(),
            // SizedBox(height: 10),
            _termsAndPrivacyBuilder(),
            SizedBox(height: 10),
            _saveButtonBuilder(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _idBuilder() {
    return // ID
        !ctr.isEditing.value
            ? Column(
                children: [
                  CustomField(
                    buttonText: 'check_available'.tr,
                    fieldController: ctr.idController,
                    fieldText: 'EX)id1234',
                    onTap: () {
                      ctr.checkIdAvailableBtnPressed();
                    },
                    fieldLabel: '아이디',
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              )
            : SizedBox.shrink();
  }

  _emailBuilder() {
    return CustomField(
      fieldLabel: '이메일',
      fieldText: '이메일 주소를 입력해주세요.',
      fieldController: ctr.emailController,
    );
  }

  Widget _passwordBuilder() {
    return // Password
        !ctr.isEditing.value
            ? Column(
                children: [
                  CustomField(
                    fieldLabel: '비밀번호',
                    fieldText: '숫자, 영문, 특수문자 최소 8자',
                    fieldController: ctr.passwordController,
                    isObscureText: true,
                  ),
                  SizedBox(height: 15),
                  CustomField(
                    fieldLabel: 'verify_password'.tr,
                    fieldText: '비밀번호를 한번 더 입력해주세요',
                    fieldController: ctr.passwordVerifyController,
                    isObscureText: true,
                  ),
                  SizedBox(height: 15),
                ],
              )
            : SizedBox.shrink();
  }

  Widget _nameBuilder() {
    return CustomField(
        fieldLabel: 'name'.tr,
        fieldText: '이름을 입력해주세요.',
        fieldController: ctr.nameController);
  }

  Widget _addressBuilder() {
    return Column(
      children: [
        CustomField(
          readOnly: true,
          fieldText: 'Zip_code'.tr,
          buttonText: '주소 검색',
          fieldController: ctr.address1Controller,
          onTap: () {
            ctr.searchAddressBtnPressed();
          },
          fieldLabel: 'address'.tr,
        ),
        SizedBox(height: 10),
        // address fields
        CustomTextField(
          readOnly: true,
          labelText: '주소 입력',
          controller: ctr.address2Controller,
        ),
        SizedBox(height: 10),
        CustomTextField(
          labelText: 'Address details'.tr,
          controller: ctr.address3Controller,
        ),
      ],
    );
  }

  Widget _phoneNumberPhoneVerifyBuilder() {
    return !ctr.isEditing.value
        ? Column(
            children: [
              PhoneNumberPhoneVerify(
                spaceBetween: 15,
              ),
              SizedBox(height: 15),
            ],
          )
        : SizedBox.shrink();
  }

  // Widget _birthdayBuilder() {
  //   return Column(
  //     children: [
  //       Align(alignment: Alignment.centerLeft, child: Text('birthday'.tr)),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Expanded(
  //             child: CustomTextField(
  //               readOnly: ctr.isEditing.value ? true : false,
  //               labelText: '',
  //               controller: ctr.birthdayYear,
  //               keyboardType: TextInputType.number,
  //             ),
  //           ),
  //           SizedBox(width: 10),
  //           Text('year'.tr),
  //           SizedBox(width: 10),
  //           Expanded(
  //             child: CustomTextField(
  //               readOnly: ctr.isEditing.value ? true : false,
  //               labelText: '',
  //               controller: ctr.birthdayMonth,
  //               keyboardType: TextInputType.number,
  //             ),
  //           ),
  //           SizedBox(width: 10),
  //           Text('month'.tr),
  //           SizedBox(width: 10),
  //           Expanded(
  //             child: CustomTextField(
  //               readOnly: ctr.isEditing.value ? true : false,
  //               labelText: '',
  //               controller: ctr.birthdayDay,
  //               keyboardType: TextInputType.number,
  //             ),
  //           ),
  //           SizedBox(width: 10),
  //           Text('day'.tr),
  //         ],
  //       )
  //     ],
  //   );
  // }

  Widget _termsAndPrivacyBuilder() {
    return !ctr.isEditing.value
        ? Column(
            children: [
              Divider(thickness: 6, color: MyColors.grey3),
              _agreeToAll(),
              _termsAndConditions(),
              _privacyPolicy(),
            ],
          )
        : SizedBox.shrink();
  }

  Widget _agreeToAll() {
    return Obx(
      () => Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
                activeColor: MyColors.secondaryColor,
                value: ctr.isAgreeToAll.value,
                onChanged: (value) {
                  ctr.isAgreeToAll.value = value!;
                  ctr.firstConditions.value = value;
                  ctr.secondConditions.value = value;
                }),
          ),
          SizedBox(width: 5),
          Text('전체동의'),
        ],
      ),
    );
  }

  Widget _termsAndConditions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 110,
              child: Text('이용약관동의'),
            ),
            SizedBox(width: 10),
            CustomButton(
              onPressed: () {
                Get.to(() => User_RegisterPrivacyTermsView(),
                    arguments: PrivacyOrTerms.terms);
              },
              text: '자세히보기',
              textColor: MyColors.black2,
              fontSize: 12,
              backgroundColor: MyColors.grey1,
              borderColor: MyColors.grey1,
            )
          ],
        ),
        Row(
          children: [
            Obx(
              () => Checkbox(
                  activeColor: MyColors.secondaryColor,
                  value: ctr.firstConditions.value,
                  onChanged: (value) {
                    ctr.firstConditions.value = value!;
                    if (!ctr.firstConditions.value) {
                      ctr.isAgreeToAll.value = false;
                    }
                    if (ctr.firstConditions.value &&
                        ctr.secondConditions.value) {
                      ctr.isAgreeToAll.value = true;
                    }
                  }),
            ),
            Text('동의'),
          ],
        )
      ],
    );
  }

  Widget _privacyPolicy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 120,
              child: Text('개인정보취급방침'),
            ),
            CustomButton(
              textColor: MyColors.black2,
              fontSize: 12,
              onPressed: () {
                Get.to(() => User_RegisterPrivacyTermsView(),
                    arguments: PrivacyOrTerms.privacy);
              },
              text: '자세히보기',
              backgroundColor: MyColors.grey1,
              borderColor: MyColors.grey1,
            )
          ],
        ),
        Row(
          children: [
            Obx(
              () => Checkbox(
                  activeColor: MyColors.secondaryColor,
                  value: ctr.secondConditions.value,
                  onChanged: (value) {
                    ctr.secondConditions.value = value!;
                    if (!ctr.secondConditions.value) {
                      ctr.isAgreeToAll.value = false;
                    }
                    if (ctr.firstConditions.value &&
                        ctr.secondConditions.value) {
                      ctr.isAgreeToAll.value = true;
                    }
                  }),
            ),
            Text('동의'),
          ],
        )
      ],
    );
  }

  Widget _saveButtonBuilder() {
    return CustomButton(
      width: Get.width,
      onPressed: () {
        ctr.saveOrEditBtnPressed();
        // Get.back();
      },
      text: ctr.isEditing.value ? '수정' : '회원가입',
    );
  }
}
