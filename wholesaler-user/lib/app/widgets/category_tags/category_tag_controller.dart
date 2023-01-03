import 'package:get/get.dart';

class CategoryTagController extends GetxController {
  RxInt selectedMainCatIndex = 0.obs;
  RxInt selectedSubCatIndex = 0.obs;
  RxBool isDingDongTab = false.obs; // For Dingdong tab: show "인기", for all other pages, show "ALL"

  @override
  void onInit() {
    super.onInit();
  }
}
