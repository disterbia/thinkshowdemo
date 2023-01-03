import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/inquiries_model.dart';

class InquryPageController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();
  RxList<int> isExapnded = <int>[].obs;
  RxBool isLoading=false.obs;

  RxList<InquiriesPageModel> inquires = <InquiriesPageModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value=true;
    inquires.value = await _apiProvider.getInquiryList(limit: 50);
    isLoading.value=false;
  }
}
