import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/ad/controllers/ad_controller.dart';
import 'package:wholesaler_partner/app/modules/ad/tab1_ad_status/view/tab1_ad_status_view.dart';
import 'package:wholesaler_partner/app/modules/ad/tab2_ad_application/view/tab2_ad_application_view.dart';
import 'package:wholesaler_partner/app/modules/ad/tab3_ad_apply_history/view/tab3_ad_apply_history.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class AdView extends StatelessWidget {
  AdController ctr = Get.put(AdController());

  init() {
    ctr.currentTab.value = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    print('AdView build Get.arguments ${Get.arguments}');
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(isBackEnable: true, title: 'ad_apply'.tr),
      body: DefaultTabController(
        length: 2, // length of tabs
        initialIndex: ctr.currentTab.value,
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              child: TabBar(
                controller: ctr.tabController,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: 'Advertising_Status'.tr),
                  //Tab(text: 'ad_apply'.tr),
                  Tab(text: 'Application_history'.tr),
                ],
              ),
            ),
            Container(
              height: context.height - 190,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
              ),
              child: TabBarView(
                controller: ctr.tabController,
                children: [
                  Tab1AdStatusView(),
                  //Tab2AdApplicationView(),
                  Tab3AdApplicationHistoryView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
