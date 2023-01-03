import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/orders_inquiry_review_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/widgets/order_or_review_item.dart';
import 'package:wholesaler_user/app/models/order_model.dart';

class OrderItemListView extends StatelessWidget {
  OrderInquiryAndReviewController ctr = Get.put(OrderInquiryAndReviewController());

  bool isReviewPage;
  OrderOrReview order;
  OrderItemListView({required this.isReviewPage, required this.order});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: order.products.length,
      separatorBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Divider(height: 2, color: Colors.grey),
      ),
      itemBuilder: (BuildContext context, int productIndex) {
        // OrderItem ListView
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: OrderOrReviewItem(
            isReviewPage: isReviewPage,
            item: order,
            productId: productIndex,
          ),
        );
      },
    );
  }
}
