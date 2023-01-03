import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/ad_history_model/application_detail_list.dart';
import 'package:wholesaler_partner/app/modules/ad/tab3_ad_apply_history/controller/tab3_ad_apply_history_controller.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

Tab3AdApplyHistoryPaymentDialog({required ApplicationDetailList tempApplicationDetail}) {
  Tab3AdApplicationHistoryController ctr = Get.put(Tab3AdApplicationHistoryController());
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) => Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 200,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('결제하시겠습니까?', style: MyTextStyles.f16.copyWith(color: MyColors.black2)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('포인트 차감'),
                SizedBox(width: 20),
                Text(
                  Utils.numberFormat(number: tempApplicationDetail.cost!) + 'P',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(height: 14),
            TwoButtons(
              leftBtnText: '취소',
              rightBtnText: '결제',
              lBtnOnPressed: () {
                Get.back();
              },
              rBtnOnPressed: () => ctr.adPaymentBtnPressed(tempApplicationDetail.id!),
            )
          ],
        ),
      ),
    ),
  );
}
