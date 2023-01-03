import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/src/calendar/common/event_args.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/modules/ad/controllers/ad_controller.dart';
import 'package:wholesaler_partner/app/modules/ad/tab2_ad_application/model/ad_tab2_apply_model.dart';
import 'package:wholesaler_partner/app/modules/ad/views/ad_view.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/dialog.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'package:wholesaler_user/app/widgets/web_view_widget.dart';

class Tab2AdApplicationController extends GetxController {
  Rx<AdTab2ApplyModel> tab2AdApplyModel = AdTab2ApplyModel().obs;
  pApiProvider _apiProvider = pApiProvider();
  RxString Month = ''.obs;

  RxList<DateTime> selectedDates = <DateTime>[].obs;
  RxList<DateTime> notApplicableDateTimes = <DateTime>[].obs;

  RxBool isAdAvailable = false.obs;
  RxBool isLoading = false.obs;
  int adsId = Get.arguments;

  init() async {
    isLoading.value=true;
    var response = await _apiProvider.getAdTab2AdApplyInquiry(adsId);
    if (response != null) {
      tab2AdApplyModel.value = response;
      // convert to date time
      for (String dateStr in tab2AdApplyModel.value.notApplicableDateList!) {
        notApplicableDateTimes.add(Utils.toDateDash(date: dateStr));
      }
      isAdAvailable.value = true;
    } else {
      isAdAvailable.value = false;
    }
    isLoading.value=false;
  }

  calendarCellTapped(CalendarTapDetails calendarTapDetails) {
    // if tap on already applied cell, deselect it
    if (selectedDates.contains(calendarTapDetails.date!)) {
      print("aaaaaaaa");
      selectedDates.remove(calendarTapDetails.date!);
      return;
    }

    // if tap on not applicable do nothing
    if (notApplicableDateTimes.contains(calendarTapDetails.date!)) {
      print("bbbbbbbbb");
      return;
    }

    selectedDates.add(calendarTapDetails.date!);
    print(selectedDates);
  }

  /// Apply Button 신청하기
  applyBtnPressed() async {
    // If no date is selected
    if (selectedDates.isEmpty) {
      mSnackbar(message: '광고 날짜를 선택하세요.', duration: 1);
      return;
    }

    bool isSuccess = await _apiProvider.postAdTab2AdApplication(
        adApplicationId: tab2AdApplyModel.value.id!,
        applicationDates: selectedDates.value);

    // if (isSuccess) {
    //   Get.to(AdView(), arguments: AdTabs.Tab3AdApplicationHistory.index);
    // }
  }

  adPolicyBtnPressed() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.all(0),
        child: Container(
          width: Get.width * 0.9,
          height: Get.height * 0.8,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('광고정책 및 약관'),
              SizedBox(height: 20),
              Container(
                height: Get.height * 0.6,
                child: WebViewWidget(
                    url: mConst.API_BASE_URL +
                        '/web/staff/advertisement-policy'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('닫기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
