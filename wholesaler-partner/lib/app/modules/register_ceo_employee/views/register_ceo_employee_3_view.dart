import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/business_registration_submit/controllers/business_registration_submit_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_1_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_3_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/widgets/upload_image_container_empty.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/widgets/upload_image_container_uploaded.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';

class RegisterCeoEmployeePage3View extends GetView {
  RegisterCeoEmployee3Controller ctr =
      Get.put(RegisterCeoEmployee3Controller());
  RegisterCeoEmployee1Controller registerCeoEmployeeCtr =
      Get.put(RegisterCeoEmployee1Controller());
  BusinessRegistrationSubmitController registerImageSubmitCtr =
      Get.put(BusinessRegistrationSubmitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(
        isBackEnable: true,
        title:
            '회원가입 (${registerCeoEmployeeCtr.isEmployee.value ? '직원' : '대표'})',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              // Company name - 상호명
              registerCeoEmployeeCtr.isEmployee.isFalse
                  ? Column(
                      children: [
                        CustomField(
                            fieldLabel: '회사명',
                            fieldText: '상호명을 입력해주세요.',
                            fieldController: ctr.companyNameCtr),
                        SizedBox(height: 16),
                      ],
                    )
                  : SizedBox(),

              // CEO / staff name
              CustomField(
                  fieldLabel: registerCeoEmployeeCtr.isEmployee.isFalse
                      ? '대표자 이름'
                      : '직원 이름',
                  fieldText: '성함을 입력해주세요.',
                  fieldController: ctr.ceoNameCtr),

              SizedBox(height: 16),
              // ID
              CustomField(
                fieldLabel: 'id'.tr,
                fieldText: 'EX)id1234',
                fieldController: ctr.idCtr,
                onTap: () {
                  ctr.verifyIdPressed();
                },fontSize: 13,
                buttonText: 'check_availability'.tr,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
                ],
              ),

              SizedBox(height: 16),
              // Password

              CustomField(
                fieldLabel: 'password'.tr,
                fieldText: '비밀번호를 입력해주세요.',
                fieldController: ctr.passwordCtr,
                isObscureText: true,
              ),

              SizedBox(height: 16),
              // Password verify
              CustomField(
                fieldLabel: 'password_verify'.tr,
                fieldText: '비밀번호를 한번 더 입력해주세요.',
                fieldController: ctr.passwordVerifyCtr,
                isObscureText: true,
              ),

              SizedBox(height: 16),
              // Business Registration Number

              registerCeoEmployeeCtr.isEmployee.value
                  ? SizedBox()
                  : CustomField(
                      fieldLabel: 'business_register_number'.tr,
                      fieldText: 'EX) NNN - NN - NNNNN',
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                      ],
                      fieldController: ctr.BusinessRegisterNumCtr,
                      isTextKeyboard: true,
                    ),
              // Submit Business Registration File
              registerCeoEmployeeCtr.isEmployee.isFalse
                  ? Column(
                      children: [
                        SizedBox(height: 35),
                        Text('사업자등록증 등록'),
                        SizedBox(height: 6),
                        Obx(() =>
                            registerImageSubmitCtr.uploadedImageURL.isEmpty
                                ? UploadImageContainer_empty()
                                : UploadImageContainer_uploaded()),
                      ],
                    )
                  : SizedBox(),

              SizedBox(height: 40),

              // Next Button
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButton(
                  onPressed: () {
                    ctr.nextBtnPressed();
                  },
                  text: '다음',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
