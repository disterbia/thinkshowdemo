import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/business_license/controller/business_license_controller.dart';
import 'package:wholesaler_partner/app/modules/business_registration_submit/controllers/business_registration_submit_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/widgets/upload_image_container_empty.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/widgets/upload_image_container_uploaded.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';

class BusinessEditView extends StatelessWidget {
  BusinessLicenseController ctr = Get.put(BusinessLicenseController());
  BusinessRegistrationSubmitController registerImageSubmitCtr =
      Get.put(BusinessRegistrationSubmitController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(
        isBackEnable: true,
        title: '사업자정보 수정',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          CustomField(
            fieldLabel: 'business_register_number'.tr,
            fieldText: 'EX) NNN - NN - NNNNN',
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
            fieldController: ctr.BusinessRegisterNumCtr,
            isTextKeyboard: true,
          ),
          SizedBox(height: 16),
          Obx(() => registerImageSubmitCtr.uploadedImageURL.isEmpty
              ? UploadImageContainer_empty()
              : UploadImageContainer_uploaded()),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              width: Get.width,
              onPressed: ()=>
                ctr.validateLicense(),

              text: 'edit'.tr,
            ),
          )
        ]),
      ),
    );
  }


}
