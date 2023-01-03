import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/appbar_widget.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';

import '../controllers/my_bank_account_mgmt_controller.dart';

class MyBankAccountMgmtView extends GetView<MyBankAccountMgmtController> {
  MyBankAccountMgmtController ctr = Get.put(MyBankAccountMgmtController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppbar(isBackEnable: true, hasHomeButton: false, title: '내 계좌번호 등록'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ctr.isLoading.value
                ? LoadingWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 22),
                      // Bank Name: 은행선택
                      CustomField(
                        fieldLabel: 'select_bank'.tr,
                        fieldText: ctr.accountName.value,
                        fieldController: ctr.bankController,
                      ),
                      SizedBox(height: 16),
                      // Bank Account Holder: 예금주 입력

                      CustomField(
                        fieldLabel: 'account_holder'.tr,
                        fieldText: ctr.accountOwnerName.value,
                        fieldController: ctr.holderNameController,
                      ),

                      SizedBox(height: 16),
                      // Bank Account Number: 계좌번호 입력
                      CustomField(
                        fieldLabel: 'account_number'.tr,
                        fieldText: ctr.accountNumber.value,
                        fieldController: ctr.accountController,
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          width: Get.width,
                          onPressed: ctr.saveAccountInfo,
                          text: 'register'.tr,
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
