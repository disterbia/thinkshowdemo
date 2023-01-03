import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/models/ad_history_model/ad_history_model.dart';
import 'package:wholesaler_partner/app/models/ad_history_model/application_detail_list.dart';
import 'package:wholesaler_partner/app/modules/ad/tab1_ad_status/controller/tab1_ad_status_controller.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/controller/product_mgmt_controller.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/view/product_mgmt_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Tab3AdApplicationHistoryController extends GetxController {
  Tab1AdStatusController ctr = Get.put(Tab1AdStatusController());
  RxBool isLoading = false.obs;
  final pApiProvider _apiProvider = pApiProvider();
  String title = '';
  TextEditingController dailyBudgetController = TextEditingController();
  // String firstAmount = '';
  // String secondAmount = '';

  Rx<HistoryAdModel> advertisements = HistoryAdModel().obs;

  @override
  void onInit() async {
    await getHistory();
  }

  init() async {
    await getHistory();
  }

  Future<void> getHistory() async {
    isLoading.value = true;
    advertisements.value = await _apiProvider.getApplicationHistory();

    isLoading.value = false;
  }

  addAdProductsBtnPressed(ApplicationDetailList tempApplicationDetail) {
    Get.put(ProductMgmtController()).isBottomNavbar.value = true;
    Get.put(ProductMgmtController()).applicationId = tempApplicationDetail.id!;
    Get.to(() => ProductMgmtView(isRegisterAdProductPage: true), arguments: tempApplicationDetail.id!);
  }

  adPaymentBtnPressed(int advertisement_application_id) async {
    await _apiProvider.adPayment(advertisement_application_id);
    await getHistory();
    await ctr.getPoints();
    Get.back();
  }

  adBudgetBtnPressed(int advertisement_application_id, String amount) async {
    // check if amount is empty
    if (amount.isEmpty) {
      mSnackbar(message: '예산을 입력해주세요.');
      return;
    }

    // check if amount is only number
    if (!amount.contains(RegExp(r'^[0-9]*$'))) {
      mSnackbar(message: '숫자만 입력하세요.');
      return;
    }

    // check if amount is not zero
    if (amount == '0') {
      mSnackbar(message: '예산은 0원을 입력할 수 없습니다.');
      return;
    }

    // convert amount to int
    int amountInt = int.parse(amount);

    bool isSuccess = await _apiProvider.putAdBudget(advertisement_application_id, amountInt);
    if (isSuccess) {
      // await getHistory();
      Get.back();
    }
  }
}
