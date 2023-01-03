import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wholesaler_partner/app/modules/ad_impression/views/ad_list_tile_widget.dart';
import 'package:wholesaler_partner/app/widgets/ad_tags.dart';
import 'package:wholesaler_partner/app/widgets/appbar_widget.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_partner/app/widgets/two_text_container_widget.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_widget.dart';

import '../controllers/ad_impression_controller.dart';

class AdImpressionView extends GetView {
  AdImpressionController ctr = Get.put(AdImpressionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(isBackEnable: true, title: '쇼핑에드'),
        body: SingleChildScrollView(
          child: Obx(
            () => ctr.isLoading.value
                ? LoadingWidget()
                : Column(
                    children: [
                      SizedBox(height: 20),
                      // Chips
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: AdTags(
                          chipsName: ctr.tags,
                          onTap: (index) => ctr.categoryTagChanged(index),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'adve'
                                      'rtising_performance'
                                  .tr,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 10),
                            RangeDatePicker(
                              startDateController: ctr.endDateController,
                              endDateController: ctr.startDateController,
                              onSubmit: () => ctr.dateRangeSubmitted(),
                            ),
                            SizedBox(height: 15),
                            // 노출수, 클릭수, 클릭
                            Row(
                              children: [
                                Expanded(
                                    child: TwoTextContainer(
                                        topText: '노출수',
                                        bottomText: ctr.impression.value)),
                                SizedBox(width: 10),
                                Expanded(
                                    child: TwoTextContainer(
                                        topText: '클릭수',
                                        bottomText: '${ctr.clicks.value}회')),
                                SizedBox(width: 10),
                                Expanded(
                                    child: TwoTextContainer(
                                        topText: '클릭률',
                                        bottomText: '${ctr.clickRate.value}%')),
                              ],
                            ),
                            SizedBox(height: 10),
                            // 찜수, 구매전환률, 총 광고비용
                            Row(
                              children: [
                                Expanded(
                                    child: TwoTextContainer(
                                        topText: '찜수',
                                        bottomText: ctr.favoriteCount.value)),
                                SizedBox(width: 10),
                                Expanded(
                                    child: TwoTextContainer(
                                        topText: '구매전환률',
                                        bottomText: '${ctr.orderRate.value}%')),
                                SizedBox(width: 10),
                                Expanded(
                                    child: TwoTextContainer(
                                        topText: '총 광고비용',
                                        bottomText: '${ctr.totalCost.value}')),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('impressions'.tr),
                                SizedBox(width: 10),
                                Text('${ctr.impression.value}회'),
                              ],
                            ),
                            SizedBox(height: 20),
                            // Circular progress bars
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularPercentIndicator(
                                  radius: 80.0,
                                  lineWidth: 20,
                                  percent:
                                      double.parse(ctr.clickRate.value) / 100,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${ctr.clickRate.value}%"),
                                      Text(ctr.clicks.value),
                                    ],
                                  ),
                                  progressColor: Colors.orange[400],
                                  backgroundColor: Colors.orange.shade50,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  footer: Padding(
                                    padding: const EdgeInsets.only(top: 14),
                                    child: Text('클릭수'),
                                  ),
                                ),
                                CircularPercentIndicator(
                                  radius: 80.0,
                                  lineWidth: 20,
                                  percent:
                                      double.parse(ctr.orderRate.value) / 100,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${ctr.orderRate.value}%"),
                                      Text(ctr.orderCount.value),
                                    ],
                                  ),
                                  progressColor: Colors.orange[300],
                                  backgroundColor: Colors.orange.shade50,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  footer: Padding(
                                    padding: const EdgeInsets.only(top: 14),
                                    child: Text('구매수'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Obx(
                              () => ctr.isShowDetail.isFalse
                                  ? ElevatedButton(
                                      onPressed: () {
                                        ctr.isShowDetail.value = true;
                                      },
                                      child: Text('자세히 보기'))
                                  : SizedBox.shrink(),
                            ),

                            Obx(
                              () => ctr.isShowDetail.isTrue
                                  ? _adImpressionItem()
                                  : SizedBox.shrink(),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }

  Widget _adImpressionItem() {
    return Obx(
      () => ctr.isLoading.value
          ? LoadingWidget()
          : Column(
              children: [
                for (var i = 0; i < ctr.impressionItems.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(ctr.chosenTagName.value)),
                      SizedBox(height: 10),
                      Text(ctr.impressionItems[i].date),
                      SizedBox(height: 10),
                      Text('ad_cost'.tr + ctr.impressionItems[i].cost),
                      // Ad List
                      // SizedBox(height: 8),
                      for (var j = 0;
                          j < ctr.impressionItems[i].products.length;
                          j++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AdListTile(ctr.impressionItems[i].products[j],
                              ctr.impressionItems[i].date),
                        ),
                    ],
                  ),
              ],
            ),
    );
  }
}
