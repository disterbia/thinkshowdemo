import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/ad/tab2_ad_application/controller/tab2_ad_application_controller.dart';
import 'package:wholesaler_partner/app/modules/ad/tab2_ad_application/view/calendar_view.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/web_view_widget.dart';

class Tab2AdApplicationView extends GetView {
  Tab2AdApplicationController ctr = Get.put(Tab2AdApplicationController());
  Tab2AdApplicationView();

  onInit() async {
    await ctr.init();
  }

  @override
  Widget build(BuildContext context) {
    onInit();
    return Obx(
      () => Scaffold(appBar: CustomAppbar(title: "광고신청",isBackEnable: true,),
        body: ctr.isLoading.value? LoadingWidget():SingleChildScrollView(
          child:
          ctr.isAdAvailable.value
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => Text(
                              ctr.tab2AdApplyModel.value.title ?? '',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          SizedBox(height: 10),
                          Obx(
                            () => Text(
                              ctr.tab2AdApplyModel.value.content ?? '',
                              style: MyTextStyles.f16,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () => ctr.adPolicyBtnPressed(),
                            child: Text(
                              '광고정책 및 약관',
                              style: MyTextStyles.f14_thin.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 20),
                          // Calendar Title: 6월
                          Obx(
                            () => Center(
                              child: Text(
                                ctr.tab2AdApplyModel.value.targetMonthInfo ?? '',
                                style: MyTextStyles.f18
                                    .copyWith(color: MyColors.black3),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          Obx(
                            () => ctr.tab2AdApplyModel.value
                                        .target_month_start_date !=
                                    null
                                ? Container(
                                    height: 300,
                                    child: mCalendarView(),
                                  )
                                : SizedBox.shrink(),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      color: MyColors.grey3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(
                                '1일 또는 1회 노출 기준 (24시)',
                                style: MyTextStyles.f16,
                              ),
                              Spacer(),
                              Obx(
                                () => Text(
                                  ctr.tab2AdApplyModel.value.cost != null
                                      ? Utils.numberFormat(
                                          number:
                                              ctr.tab2AdApplyModel.value.cost!,
                                          suffix: '원')
                                      : '',
                                  style: MyTextStyles.f18_bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                          CustomButton(
                            onPressed: () => ctr.applyBtnPressed(),
                            text: '신청하기',
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      '광고를 신청할 수 있는 기간이 아닙니다.',
                      style: MyTextStyles.f16,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
