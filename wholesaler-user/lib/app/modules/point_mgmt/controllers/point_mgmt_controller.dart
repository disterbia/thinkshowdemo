import 'dart:convert';

import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/point_mgmt_page_model.dart';
import 'package:wholesaler_user/app/models/user_model.dart';

class PointMgmtController extends GetxController {
  final uApiProvider userApiProvider = uApiProvider();
  final pApiProvider partnerApiProvider = pApiProvider();
  RxInt totalPoints = 0.obs;

  RxList<PointMgmtPageModel> pointMgmtList = <PointMgmtPageModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (MyVars.isUserProject()) {
      pointMgmtList.value = await userApiProvider.getPointMgmtListForUser();
    } else {
      pointMgmtList.value = await partnerApiProvider.getPointMgmtListForPartner();
    }

    // get point from getUserInfo()
    if (MyVars.isUserProject()) {
      User user = await userApiProvider.getUserInfo();
      totalPoints.value = user.points!.value;
    } else {
      dynamic response = await partnerApiProvider.getUserInfo();
      var json = jsonDecode(response.bodyString!);
      totalPoints.value = json['point'];
    }
  }
}
