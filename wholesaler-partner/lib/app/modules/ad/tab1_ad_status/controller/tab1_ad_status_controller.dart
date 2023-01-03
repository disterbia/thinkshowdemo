import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/models/ad_product_model.dart';
import 'package:wholesaler_partner/app/modules/ad/tab1_ad_status/models/ad_effectiveness_report_model.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/controller/product_mgmt_controller.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/view/product_mgmt_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Tab1AdStatusController extends GetxController {
  RangeDatePickerController rangeDatePickerCtr = Get.put(RangeDatePickerController());

  final pApiProvider _apiProvider = pApiProvider();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  List<String> adTags = ['광고R', '광고S', '광고1ST', '광고2ST', '광고3ST', '광고4ST'];
  RxInt selectedAdTagIndex = 0.obs;
  List<int> adTagNumber = [100, 200, 300, 400, 500, 600];

  RxBool isLoading = false.obs;
  RxBool isLoadingProducts = false.obs;
  RxString point = ''.obs;
  String startDate = '';
  String endDate = '';
  RxList<ExposureAdModel> exposureAds = <ExposureAdModel>[].obs;

  Rx<AdEffectiveReportModel> adEffectiveReportModel = AdEffectiveReportModel(store_visit_count: '', order_total_amount: '', privilge_order_total_amount: '').obs;

  @override
  void onInit() async {
    await getPoints();

    startDate = correctDateFormat(rangeDatePickerCtr.tempStartDate);
    endDate = correctDateFormat(rangeDatePickerCtr.tempEndDate);

    startDateController.text = startDate;
    endDateController.text = endDate;

    await callGetAdEffectiveReportAPI(startDate, endDate);
    await callGetAdExposureProducts(adTagIndex: 0);
  }

  String correctDateFormat(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }

  Future<void> getPoints() async {
    isLoading.value = true;
    await _apiProvider.getPoint().then((response) {
      point.value = Utils.numberFormat(number: response['point']);
    });
    isLoading.value = false;
  }

  Future<void> callGetAdEffectiveReportAPI(String startDate, String endDate) async {
    isLoading.value = true;
    adEffectiveReportModel.value = await _apiProvider.getAdEffectiveReport(startDate, endDate);
    isLoading.value = false;
  }

  Future<void> callGetAdExposureProducts({required int adTagIndex}) async {
    isLoadingProducts.value = true;
    // exposureAds.clear();
    exposureAds.value = await _apiProvider.getAdExposureProducts(ads_type_code: adTagNumber[adTagIndex]);

    isLoadingProducts.value = false;
  }

  deleteAdProductBtnPressed(int adIndex, productIndex) async {
    bool isSuccess = await _apiProvider.deleteAdProduct(exposureAds[adIndex].ads_application_id, exposureAds[adIndex].adProducts[productIndex].id);

    if (isSuccess) {
      exposureAds[adIndex].adProducts.removeAt(productIndex);
      await callGetAdExposureProducts(adTagIndex: selectedAdTagIndex.value);
    }
  }

  // 상품을 등록해주세요 button pressed
  addOrEditAdProductsBtnPressed(int exposureAdIndex) {
    Get.put(ProductMgmtController()).isBottomNavbar.value = true;
    Get.put(ProductMgmtController()).applicationId = exposureAds[exposureAdIndex].ads_application_id;
    Get.to(() => ProductMgmtView(isRegisterAdProductPage: true), arguments: exposureAds[exposureAdIndex].ads_application_id);
  }

  // After the user selects products from Products Mgmt page
  Future<void> addToAdProduct({required List<int> productsId, required int ads_application_id}) async {
    print('addToAdProduct productsId $productsId ads_application_id $ads_application_id');
    bool isSuccess = await _apiProvider.addToAd(data: {"product_ids": productsId}, adApplicationId: ads_application_id);

    if (isSuccess) {
      mSnackbar(message: '추가 완료되었습니다.');
      print('selectedAdTagIndex ${selectedAdTagIndex.value}');
      await callGetAdExposureProducts(adTagIndex: selectedAdTagIndex.value);
      Get.back();
    }
  }
}
