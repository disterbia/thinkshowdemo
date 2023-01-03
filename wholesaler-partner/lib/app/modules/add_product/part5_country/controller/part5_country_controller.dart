import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/add_product/country_model.dart';

class AP_Part5Controller extends GetxController {
  List<String> countries = [
    '대한민국',
    '중국',
    '직접입력',
  ];
  Rx<String> selectedCountry = '대한민국'.obs;

  late TextEditingController directController;

  @override
  void onInit() {
    directController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    directController.dispose();
    super.dispose();
  }
}
