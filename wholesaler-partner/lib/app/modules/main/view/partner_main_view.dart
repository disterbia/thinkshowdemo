import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/page1_home/view/page1_home_view.dart';
import 'package:wholesaler_partner/app/modules/page2_order_history/views/page2_order_history_view.dart';
import 'package:wholesaler_partner/app/modules/page3_my_page/views/page3_my_page_view.dart';
import 'package:wholesaler_partner/app/widgets/bottom_navbar/bottom_navbar_controller.dart';
import 'package:wholesaler_partner/app/widgets/bottom_navbar/bottom_navbar_view.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/data/firebase_service.dart';

import '../controller/partner_main_controller.dart';

class PartnerMainView extends GetView<BottomNavbarController> {
 // PartnerMainController ctr = Get.put(PartnerMainController());
  BottomNavbarController navbarCtr = Get.put(BottomNavbarController());

  @override
  Widget build(BuildContext context) {
    FirebaseService.init();
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: Obx(
          () => appBarBuilder(navbarCtr.tabIndex.value),
        ),
      ),
      bottomNavigationBar: PartnerBottomNavbarView(),
      body: Obx(() => bodyBuilder.elementAt(navbarCtr.tabIndex.value)),
    );
  }
}

List<Widget> bodyBuilder = [
  Page1HomeView(),
  Page2OrderHistoryView(),
  Page3MyPageView(),
];

appBarBuilder(int index) {
  if (index == 0) {
    // Home tab appbar
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Image.asset(
        'assets/images/partner_home_appbar_logo.png',
        width: 60,
      ),
    );
  } else if (index == 1) {
    // Order history
    return CustomAppbar(isBackEnable: false, title: 'orderHistory'.tr);
  } else if (index == 2) {
    // My page
    return CustomAppbar(isBackEnable: false, title: 'myPage'.tr);
  }
}
