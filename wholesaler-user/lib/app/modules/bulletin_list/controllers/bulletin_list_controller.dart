import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';

import '../../../data/api_provider.dart';
import '../../../models/bulletin_model.dart';

class BulletinListController extends GetxController {
  RxList<BulletinModel> bulletins = <BulletinModel>[].obs;
  uApiProvider userApiProvider = uApiProvider();
  pApiProvider partnerApiProvider = pApiProvider();
  RxBool isLoading = false.obs;

  getBulletins() {
    isLoading.value = true;

    if (MyVars.isUserProject()) {
      userApiProvider.getUserBulletins().then((response) {
        bulletins.clear();
        bulletins.addAll(response);
        isLoading.value = false;
      });
    } else {
      partnerApiProvider.getPartnerBulletins().then((response) {
        bulletins.clear();
        bulletins.addAll(response);
        isLoading.value = false;
      });
    }
  }
}
