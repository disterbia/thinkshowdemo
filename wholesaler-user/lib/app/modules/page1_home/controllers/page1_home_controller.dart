import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/enum.dart';

/// Warning Don't confuse [Tab1Home] with [Page1Home]. Inside Page1 we have tab1 with the name Home
class Page1HomeController extends GetxController {
  RxInt tabBarIndex = UserHomeTabs.home.index.obs;
  List<Tab> homeTabTitles = [Tab(text: 'home'.tr), Tab(text: 'best'.tr), Tab(text: 'new'.tr), Tab(text: 'Dingdong'.tr), Tab(text: ' dingpick'.tr)];
}
