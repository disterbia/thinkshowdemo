import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionAndAnswerController extends GetxController {
  TextEditingController orderNumberController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  List<String> categoryDropdownItems = ['top'.tr, 'return'.tr, 'Request_new_product'.tr, '기타'];
  RxString categoryDropdownIndex = ''.obs;
}
