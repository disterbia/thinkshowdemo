import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/modules/sales_mgmt/controllers/sales_mgmt_controller.dart';
import 'package:wholesaler_partner/app/modules/sales_mgmt/views/tab_content_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class SalesMgmtView extends GetView {
  SalesMgmtController ctr = Get.put(SalesMgmtController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(isBackEnable: true, title: '매출관리'),
      body: SingleChildScrollView(
        // controller: ctr.scrollController.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 10),
              child: Text(
                'Wholesale_report'.tr,
                style: MyTextStyles.f16.copyWith(
                  color: MyColors.black3,
                ),
              ),
            ),
            DefaultTabController(
              length: 4, // length of tabs
              initialIndex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: TabBar(
                      controller: ctr.productTabController,
                      labelColor: Colors.black,
                      indicatorColor: Colors.black,
                      tabs: ctr.productTabs,
                    ),
                  ),
                  Container(
                    height: context.height - 180,
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
                    child: TabBarView(
                      controller: ctr.productTabController,
                      children: [
                        // AD impressions 노출수
                        Container(
                          child: SalesMgmtContentTabWidget(SalesTab.Impressions),
                        ),
                        // Product Clicks 클릭수
                        Container(
                          child: SalesMgmtContentTabWidget(SalesTab.Clicks),
                        ),
                        // Product Likes - 찜수
                        Container(
                          child: SalesMgmtContentTabWidget(SalesTab.Likes),
                        ),
                        // Product Orders - 주문수
                        Container(
                          child: SalesMgmtContentTabWidget(SalesTab.Orders),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
