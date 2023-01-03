import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/order_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class OrderInquiryAndReviewController extends GetxController {
  CategoryTagController categoryTagCtr = Get.put(CategoryTagController());
  uApiProvider _apiProvider = uApiProvider();
  bool? isReviewPage;

  RxList<OrderOrReview> items = <OrderOrReview>[].obs;

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isReviewPage = Get.arguments;
   // print('OrderInquiryAndReviewController onInit isReviewPage ${isReviewPage}');
    if (isReviewPage!) {
     // print('REVIEW PAGE');
      items.value = await _apiProvider.getUserReviews();
      allowCallAPI.value = false;
    } else {
      //print('ORDER INQUIRY PAGE');
      getInquiryData();

      scrollController.value.addListener(() {
        if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent && allowCallAPI.isTrue) {
          offset += mConst.limit;
          updateProduct(isScrolling: true, period: getPeriodText());
        }
      });
    }
  }

  getInquiryData() async {
    items.value = await _apiProvider.getOrderInquiry(period: OrderInquiryPeriod.total, offset: offset, limit: mConst.limit);

    if (items.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }

  periodChipPressed() async {
    offset = 0;
    allowCallAPI.value = true;
    // Period is 전체
    updateProduct(isScrolling: false, period: getPeriodText());
  }

  Future<void> updateProduct({required bool isScrolling, required String period}) async {
    if (!isScrolling) {
      offset = 0;
      items.clear();
      allowCallAPI.value = true;
    }
    List<OrderOrReview> tempItems = await _apiProvider.getOrderInquiry(period: period, offset: offset, limit: mConst.limit);

    items.addAll(tempItems);

    if (tempItems.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }

  getPeriodText() {
    String period;
    if (categoryTagCtr.selectedMainCatIndex == 0) {
      period = OrderInquiryPeriod.total;
    } else if (categoryTagCtr.selectedMainCatIndex == 1) {
      period = OrderInquiryPeriod.threeMonth;
    } else {
      period = '';
    }
    return period;
  }

  // 구매확정 button pressed
  orderSettledBtnPressed(int orderDetailId) async {
   // print('orderSettledBtnPressed orderDetailId: $orderDetailId');
    bool isSuccess = await _apiProvider.orderSettled(orderDetailId);

    if (isSuccess) {
      mSnackbar(message: '구매확정 완료');
      getInquiryData();
    }
  }
}
