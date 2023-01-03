import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/models/ad_order_model/ad_order_model.dart';

class AdOrderController extends GetxController {
  Rx<AdOrderModel> adOrderModel = AdOrderModel(cost: -1).obs;
  pApiProvider _apiProvider = pApiProvider();
  RxBool isLoading = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();

    // print value of Get.arguments
    isLoading.value=true;
    adOrderModel.value = await _apiProvider.getAdOrder(advertisementId: Get.arguments);
    isLoading.value=false;
  }
}
