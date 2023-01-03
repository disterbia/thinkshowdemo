import 'dart:developer';

import 'package:get/get.dart';

class UserIdResultController extends GetxController {
  RxString userId = ''.obs;
  var arguments = Get.arguments;


  @override
  void onInit() {
    super.onInit();
    userId.value = arguments[0]['accountId'].toString();
  }

}
