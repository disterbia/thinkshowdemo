import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/page2_order_history/controllers/page2_order_history_controller.dart';
// import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';

class OrderItemCard extends StatelessWidget {
  Page2OrderHistoryController ctr = Get.put(Page2OrderHistoryController());

  OrderItemCard();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemCount: ctr.products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ctr.products[index].createdAt!,
              style: MyTextStyles.f14.copyWith(color: MyColors.black3),
            ),
            SizedBox(height: 5),
            ProductItemHorizontal(product: ctr.products[index]),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10);
      },
    );
  }
}
