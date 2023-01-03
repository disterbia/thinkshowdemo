import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/ad/tab3_ad_apply_history/point_charge_dialog/point_charge_dialog_view.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/point_mgmt/views/point_mgmt_view.dart';
import 'package:wholesaler_user/app/widgets/text_button.dart';

import '../tab1_ad_status/controller/tab1_ad_status_controller.dart';

class RemainingPoints extends GetView {
  Tab1AdStatusController ctr = Get.put(Tab1AdStatusController());
  RemainingPoints();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => Tab1AdStatusController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('잔여 포인트', style: MyTextStyles.f18.copyWith(color: MyColors.black3)),
        Row(
          children: [
            Obx(
              () => ctr.isLoading.value
                  ? LoadingWidget()
                  : Text(
                      ctr.point.value,
                      style: MyTextStyles.f18_bold.copyWith(color: MyColors.black3),
                    ),
            ),
            Text(
              'P',
              style: MyTextStyles.f16.copyWith(color: MyColors.black3),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => PointChargeDialog(context),
              child: Text('충전'),
            ),
          ],
        ),
        mTextButton.icon(
          text: '포인트 사용내역서',
          icon: Icons.keyboard_arrow_right,
          onPressed: () => Get.to(() => PointMgmtView()),
        ),
      ],
    );
  }
}
