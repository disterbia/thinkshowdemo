import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/ad_history_model/application_detail_list.dart';
import 'package:wholesaler_partner/app/modules/ad/tab1_ad_status/controller/tab1_ad_status_controller.dart';
import 'package:wholesaler_partner/app/modules/ad/tab3_ad_apply_history/controller/tab3_ad_apply_history_controller.dart';
import 'package:wholesaler_partner/app/modules/ad/tab3_ad_apply_history/view/budget_popup_widget.dart';
import 'package:wholesaler_partner/app/modules/ad/tab3_ad_apply_history/view/payment_popup_widget.dart';
import 'package:wholesaler_partner/app/modules/ad/widgets/remaining_points_widget.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class Tab3AdApplicationHistoryView extends GetView {
  Tab3AdApplicationHistoryController ctr = Get.put(Tab3AdApplicationHistoryController());
  Tab3AdApplicationHistoryView();
  onInit() {
    ctr.init();
  }

  @override
  Widget build(BuildContext context) {
    onInit();
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => ctr.isLoading.value
              ? LoadingWidget()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RemainingPoints(),
                          SizedBox(height: 25),
                          _Listview1Builder(),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 6,
                    //   width: double.infinity,
                    //   color: MyColors.grey3,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(20),
                    //   child: Column(
                    //     children: [
                    //       _expectedPaymentAmount(),
                    //       SizedBox(height: 25),
                    //       _completedPaymentAmount(),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _expectedPaymentAmount() {
    return Row(
      children: [
        Text(
          '결제예정',
          style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
        ),
        Spacer(),
        Text(
          Utils.numberFormat(number: ctr.advertisements.value.amountToBePaid!, suffix: '원'),
          style: MyTextStyles.f16_bold.copyWith(color: MyColors.black3),
        ),
      ],
    );
  }

  // Widget _completedPaymentAmount() {
  //   return Row(
  //     children: [
  //       Text(
  //         'Payment_completion_amount'.tr,
  //         style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
  //       ),
  //       Spacer(),
  //       Text(
  //         Utils.numberFormat(number: ctr.advertisements.value.amountCompletePaid!, suffix: '원'),
  //         style: MyTextStyles.f16_bold.copyWith(color: MyColors.black3),
  //       ),
  //     ],
  //   );
  // }

  // 광고R text
  _Listview1Builder() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ctr.advertisements.value.applicationList!.length,
      separatorBuilder: (BuildContext context, int index1) => SizedBox(height: 22),
      itemBuilder: (BuildContext context, int index1) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '쇼띵 광고 ' + ctr.advertisements.value.applicationList![index1].advertisementName! + ' 신청 내역',
              style: MyTextStyles.f16.copyWith(color: MyColors.black3),
            ),
            _Listview2Builder(index1),
          ],
        );
      },
    );
  }

  _Listview2Builder(int index1) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: ctr.advertisements.value.applicationList![index1].applicationDetailList!.length,
        separatorBuilder: (BuildContext context, int index2) => SizedBox(height: 10),
        itemBuilder: (BuildContext context, int index2) {
          ApplicationDetailList tempApplicationDetail = ctr.advertisements.value.applicationList![index1].applicationDetailList![index2];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    tempApplicationDetail.applicationDate!,
                    style: MyTextStyles.f14.copyWith(color: MyColors.black3),
                  ),
                  Spacer(),
                  // 예산설정
                  tempApplicationDetail.is_real_time_cost!
                      ? OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            // primary: MyColors.grey12,
                            elevation: 0,
                          ),
                          onPressed: () => Tab3AdApplyHistoryBudgetDialog(tempApplicationDetail: tempApplicationDetail),
                          child: Text(
                            '예산설정',
                            style: MyTextStyles.f12.copyWith(color: MyColors.black2),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(width: 10),
                  // 상품등록 or 결제하기
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: tempApplicationDetail.isComplete! ? MyColors.grey12 : MyColors.primary,
                      elevation: 0,
                    ),
                    onPressed: () =>
                        tempApplicationDetail.isComplete! ? ctr.addAdProductsBtnPressed(tempApplicationDetail) : Tab3AdApplyHistoryPaymentDialog(tempApplicationDetail: tempApplicationDetail),
                    child: Text(
                      tempApplicationDetail.isComplete! ? '상품등록' : '결제하기',
                      style: MyTextStyles.f12.copyWith(color: tempApplicationDetail.isComplete! ? MyColors.black2 : MyColors.white),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
