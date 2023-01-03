import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/ad/tab1_ad_status/controller/tab1_ad_status_controller.dart';
import 'package:wholesaler_partner/app/modules/ad/tab1_ad_status/view/ad_item_list_view.dart';
import 'package:wholesaler_partner/app/modules/ad/widgets/remaining_points_widget.dart';
import 'package:wholesaler_partner/app/widgets/ad_tags.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_controller.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_widget.dart';

class Tab1AdStatusView extends GetView {
  Tab1AdStatusController ctr = Get.put(Tab1AdStatusController());

  Tab1AdStatusView();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RangeDatePickerController());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RemainingPoints(),
          ),
          Divider(thickness: 6, color: MyColors.grey3),
          _part2(),
          Divider(thickness: 6, color: MyColors.grey3),
          SizedBox(height: 12),
          _part3(),
        ],
      ),
    );
  }

  Widget _part2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () => ctr.isLoading.value
            ? LoadingWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Text(
                    '광고효과 보고서',
                    style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                  ),
                  SizedBox(height: 12),
                  RangeDatePicker(
                    startDateController: ctr.startDateController,
                    endDateController: ctr.endDateController,
                    onSubmit: () {
                      ctr.callGetAdEffectiveReportAPI(ctr.startDateController.text, ctr.endDateController.text);
                    },
                  ),
                  SizedBox(height: 10),
                  _twoText('매장 방문수', '${ctr.adEffectiveReportModel.value.store_visit_count}명'),
                  _twoText('주문 금액', '${ctr.adEffectiveReportModel.value.order_total_amount}원'),
                  _twoText('띵동 주문 금액', '${ctr.adEffectiveReportModel.value.privilge_order_total_amount}원'),
                ],
              ),
      ),
    );
  }

  Widget _twoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: MyTextStyles.f14.copyWith(color: MyColors.black2),
          ),
          Text(
            value,
            style: MyTextStyles.f16_bold.copyWith(color: MyColors.black2),
          )
        ],
      ),
    );
  }

  Widget _part3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '노출광고',
            style: MyTextStyles.f16.copyWith(color: MyColors.black2),
          ),
          SizedBox(height: 5),
          AdTags(
              chipsName: ctr.adTags,
              onTap: (index) {
                ctr.selectedAdTagIndex.value = index;
                ctr.callGetAdExposureProducts(adTagIndex: index);
              }),
          SizedBox(height: 25),
          Obx(
            () => Text(
              ctr.adTags[ctr.selectedAdTagIndex.value],
              style: MyTextStyles.f16.copyWith(color: MyColors.black2),
            ),
          ),
          SizedBox(height: 19),

          SizedBox(height: 13),
          // Product List
          _adListBuilder(),
        ],
      ),
    );
  }

  _adListBuilder() {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: ctr.exposureAds.length,
        separatorBuilder: (BuildContext context, int adIndex) => SizedBox(height: 10),
        itemBuilder: (BuildContext context, int exposureAdIndex) {
          print('rrr ctr.exposureAds.length ${ctr.exposureAds.length}');
          if (ctr.exposureAds[exposureAdIndex].adProducts.isEmpty) {
            // add border to Container
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.grey3, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      ctr.exposureAds[exposureAdIndex].date,
                      style: MyTextStyles.f12.copyWith(color: MyColors.black2),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomButton(
                      // add padding left right 20
                      backgroundColor: MyColors.grey1,
                      borderColor: MyColors.grey1,
                      textColor: MyColors.black2,
                      fontSize: 12,
                      onPressed: () => ctr.addOrEditAdProductsBtnPressed(exposureAdIndex),
                      text: '상품을 등록해주세요',
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Products found
            return AdItemList(ctr.exposureAds[exposureAdIndex], exposureAdIndex);

            // return ListView.separated(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: ctr.exposureAds[exposureAdIndex].adProducts.length,
            //   separatorBuilder: (BuildContext context, int productIndex) => SizedBox(height: 10),
            //   itemBuilder: (BuildContext context, int productIndex) {
            //     return AdItemList(ctr.exposureAds[exposureAdIndex], exposureAdIndex);
            //   },
            // );
          }
        },
      ),
    );

    // for (var i = 0; i < ctr.exposureAds.length; i++) {
    //   // If no products submitted, Show 상품을 등록해주세요 Button
    //   if (ctr.exposureAds[i].adProducts.isEmpty) {
    //     return Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         SizedBox(height: 10),
    //         CustomButton(
    //           backgroundColor: MyColors.grey1,
    //           borderColor: MyColors.grey1,
    //           textColor: MyColors.black,
    //           onPressed: () {
    //             Get.put(ProductMgmtController()).isBottomNavbar.value = true;
    //             Get.put(ProductMgmtController()).applicationId = ctr.exposureAds[i].id;
    //             Get.to(()=>ProductMgmtView(isRegisterProductPage: true));
    //           },
    //           text: '상품을 등록해주세요',
    //         ),
    //       ],
    //     );
    //   }
    //   // if products found, show product list
    //   else {
    //     return Text('data');
    //     // return AdItemList(ctr.exposureAds[i]);
    //   }
    // }
  }
}
