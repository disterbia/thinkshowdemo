import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/ad_history_model/application_detail_list.dart';
import 'package:wholesaler_partner/app/modules/ad/tab3_ad_apply_history/controller/tab3_ad_apply_history_controller.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

Tab3AdApplyHistoryBudgetDialog({required ApplicationDetailList tempApplicationDetail}) {
  Tab3AdApplicationHistoryController ctr = Get.put(Tab3AdApplicationHistoryController());
  ctr.dailyBudgetController.text=tempApplicationDetail.budget_setting_amount.toString();
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) => Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 350,
        child: Column(
          children: [
            SizedBox(height: 10),
            Text('예산설정', style: MyTextStyles.f16.copyWith(color: MyColors.black2)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('노출 당 포인트'),
                SizedBox(width: 20),
                Text(
                  Utils.numberFormat(number: tempApplicationDetail.cost!) + 'P',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 18),

            // 일간예산
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('일간예산'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(keyboardType: TextInputType.number,
                        controller: ctr.dailyBudgetController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 0.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('원'),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: 18),
            Text('- 일간 예산이 모두 소진되면 광고가 자동 중단됩니다.', style: MyTextStyles.f14.copyWith(color: MyColors.grey2)),
            SizedBox(height: 14),
            TwoButtons(
              leftBtnText: '취소',
              rightBtnText: '확인',
              lBtnOnPressed: () {
                Get.back();
              },
              rBtnOnPressed: () => ctr.adBudgetBtnPressed(
                tempApplicationDetail.id!,
                ctr.dailyBudgetController.text,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
