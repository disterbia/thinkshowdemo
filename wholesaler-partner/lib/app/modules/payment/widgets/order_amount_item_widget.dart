import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/utils/utils.dart';

import '../../../models/payment_item_model.dart';

class OrderAmountItem extends StatelessWidget {
  PaymentItemModel currentPayment;
  OrderAmountItem({required this.currentPayment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentPayment.date,
            style: MyTextStyles.f16.copyWith(color: MyColors.black3),
          ),
          SizedBox(height: 10),
          _row('구매확정', Utils.numberFormat(number: currentPayment.purchaseConfirmation) + '원'),
          SizedBox(height: 10),
          _row('반품', Utils.numberFormat(number: currentPayment.returnAmount) + '원'),
          SizedBox(height: 10),
          _row('마진', Utils.numberFormat(number: currentPayment.fees) + '원'),
          SizedBox(height: 10),
          _row2('합계', Utils.numberFormat(number: currentPayment.sum) + '원'),
        ],
      ),
    );
  }

  _row(String leftText, String rightText) {
    return Row(
      children: [
        Text(
          leftText,
          style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
        ),
        Spacer(),
        Text(
          rightText,
          style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
        ),
      ],
    );
  }

  _row2(String leftText, String rightText) {
    return Row(
      children: [
        Text(
          leftText,
          style: MyTextStyles.f16_bold.copyWith(color: MyColors.black2),
        ),
        Spacer(),
        Text(
          rightText,
          style: MyTextStyles.f16_bold.copyWith(color: MyColors.black2),
        ),
      ],
    );
  }
}
