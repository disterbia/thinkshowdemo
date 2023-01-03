import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/business_name/controller/business_name_controller.dart';
import 'package:wholesaler_partner/app/modules/page3_my_page/controllers/page3_my_page_controller.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';


class BusinessInfo extends StatelessWidget {

  BusinessInfoController ctr = Get.put(BusinessInfoController());
  Page3MyPageController page3MyPageController = Get.put(Page3MyPageController());


  @override
  Widget build(BuildContext context) {
    return Obx(()
    {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppbar(
        isBackEnable: true, hasHomeButton: false, title: '상호명 변경'),
          body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ctr.isLoading.value
          ? LoadingWidget()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  //  상호명
                  CustomField(
                    fieldLabel: "상호명",
                    fieldText: "ctr.accountName.value,",
                    fieldController: ctr.companyNameController,
                  ),
                  SizedBox(height: 10),
                  // Bank Account Holder: 예금주 입력

                  CustomField(
                    fieldLabel: "구분",
                    fieldText: " ctr.accountOwnerName.value",
                    fieldController: ctr.typeController,
                    readOnly: true,
                  ),

                  SizedBox(height: 10),
                  // Bank Account Number: 계좌번호 입력
                  CustomField(
                    fieldLabel: "대표자명",
                    fieldText: "ctr.accountNumber.value",
                    fieldController: ctr.ownerNameController,
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  // Bank Account Holder: 예금주 입력

                  CustomField(
                    fieldLabel: "포인트",
                    fieldText: "ctr.accountName.value",
                    fieldController: ctr.pointController,
                    readOnly: true,
                  ),
                  SizedBox(height: 16),
                  CustomField(
                    fieldLabel: "건물",
                    fieldText: "ctr.accountName.value",
                    fieldController: ctr.buildingController,
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  CustomField(
                    fieldLabel: "층",
                    fieldText: "ctr.accountName.value",
                    fieldController: ctr.floorController,
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  CustomField(
                    fieldLabel: "호수",
                    fieldText: "ctr.accountName.valu",
                    fieldController: ctr.hosooController,
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  CustomField(
                    fieldLabel: "스토어 등록일시",
                    fieldText: "ctr.accountName.value",
                    fieldController: ctr.createDateController,
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      width: Get.width,
                      onPressed: ctr.saveCompanyName,
                      text: 'register'.tr,
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
