import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/payment/widgets/order_amount_item_widget.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

import '../../controllers/payment_controller.dart';

class Tab1_PaymentView extends GetView {
  PaymentController paymentCtr = Get.put(PaymentController());
  Tab1_PaymentView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => paymentCtr.isLoading.value
              ? Center(child: LoadingWidget())
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        SizedBox(height: 15),
                        Text(
                          '*주문기준입니다',
                          style: MyTextStyles.f16.copyWith(color: MyColors.grey2),
                        ),
                        SizedBox(height: 20),
                        for (var i = 0; i < paymentCtr.payments.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: OrderAmountItem(currentPayment: paymentCtr.payments[i]),
                          )
                      ],
                    ),
                    SizedBox(height: 80),
                  ],
                ),
        ),
      ),
    );
  }
}
