import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/orders_inquiry_review_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/widgets/order_item_listview.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/widgets/order_top_detail_widget.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

/// 주문조회 or 리뷰
class OrderInquiryAndReviewView extends GetView {
  OrderInquiryAndReviewController ctr = Get.put(OrderInquiryAndReviewController());
  bool isBackEnable;
  bool hasHomeButton;
  OrderInquiryAndReviewView({required this.isBackEnable, required this.hasHomeButton});

  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: isBackEnable, hasHomeButton: hasHomeButton, title: Get.arguments ? '리뷰' : 'order_history'.tr),
      body: SingleChildScrollView(
        controller: ctr.scrollController.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Get.arguments
                ? SizedBox.shrink()
                : Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: HorizontalChipList().getAllMainCat(
                        categoryList: ["3개월"],
                        onTapped: () => ctr.periodChipPressed(),
                      ),
                    ),
                  ),

            // Item list view
            Obx(
              () => ctr.items.length != 0
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ctr.items.length,
                      separatorBuilder: (BuildContext context, int index) => SizedBox.shrink(),
                      itemBuilder: (BuildContext context, int itemIndex) {
                        // OrderItem ListView
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(border: Border.all(color: MyColors.grey4), borderRadius: BorderRadius.all(Radius.circular(MyDimensions.radius))),
                          child: Column(
                            children: [
                              OrderTopDetailWidget(order: ctr.items[itemIndex]),
                              OrderItemListView(
                                isReviewPage: Get.arguments,
                                order: ctr.items[itemIndex],
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('내용 없습니다.'),
                    ),
            ),
            SizedBox(height: 10),

            // obx allowCallAPI
            Obx(
              () => ctr.allowCallAPI.isTrue
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox.shrink(),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
