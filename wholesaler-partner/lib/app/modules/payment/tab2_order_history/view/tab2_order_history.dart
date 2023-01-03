import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/payment/tab2_order_history/controller/tab2_order_history_controller.dart';
import 'package:wholesaler_partner/app/modules/payment/widgets/sales_history_item_widget.dart';

import '../../controllers/payment_controller.dart';

class Tab2_OrderHistoryView extends GetView<PaymentController> {
  Tab2_OrderHistoryController ctr = Get.put(Tab2_OrderHistoryController());
  Tab2_OrderHistoryView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 5),
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ctr.orderHistoriesCollapsed.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
                itemBuilder: (BuildContext context, int index) {
                  return SalesHistoryItem(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
