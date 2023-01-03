import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';

class AdController extends GetxController with GetSingleTickerProviderStateMixin {
  RxInt currentTab = AdTabs.Tab1AdStatus.index.obs;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    currentTab.value = Get.arguments;
    tabController.index = currentTab.value;
  }
}
