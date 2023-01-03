import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class PointChargeController extends GetxController {
  pApiProvider _apiProvider = pApiProvider();
  TextEditingController pointChargeController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // 잔여 포인트
  RxString availablePoints = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    // get user points from server
    dynamic response = await _apiProvider.getPoint();
    availablePoints.value = Utils.numberFormat(number: response['point']);
  }

  Future<void> getPoints() async {}

  chargeBtnPressed() async {
    // check if textfield is empty
    if (pointChargeController.text.isEmpty) {
      mSnackbar(message: '충전 포인트를 입력해주세요.');
      return;
    }
    // check if name is empty
    if (nameController.text.isEmpty) {
      mSnackbar(message: '입금자명 을 입력해주세요.');
      return;
    }

    // check if number is valid
    int pointInt = -1;
    try {
      pointInt = int.parse(pointChargeController.text);
    } catch (e) {
      mSnackbar(message: '숫자만 입력해주세요.');
      return;
    }

    // check if point is atleast 1000
    if (pointInt < 1000) {
      mSnackbar(message: '1000원 이상의 포인트를 충전해주세요.');
      return;
    }

    // call API
    bool isSuccess = await _apiProvider.chargePoint(point: int.parse(pointChargeController.text), name: nameController.text);

    if (isSuccess) {
      mSnackbar(message: '충전신청 정상적으로 완료 되었습니다.');
      Get.back();
    }
  }
}
