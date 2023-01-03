import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/page2_order_history/widgets/order_item_card.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_widget.dart';

import '../controllers/page2_order_history_controller.dart';

class Page2OrderHistoryView extends GetView {
  Page2OrderHistoryController ctr = Get.put(Page2OrderHistoryController());

  init() {
    ctr.init();
  }
  @override
  Widget build(BuildContext context) {
    init();
    return Obx(() {
      return ctr.isLoading.value
          ? LoadingWidget()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SingleChildScrollView(
                controller: ctr.scrollController.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RangeDatePicker(
                      startDateController: ctr.endDateController,
                      endDateController: ctr.startDateController,
                      onSubmit: () => ctr.getOrders(isScrolling: false),
                    ),
                    SizedBox(height: 33),
                    Row(
                      children: [
                        Text(
                          '주문금액',
                          style: MyTextStyles.f18.copyWith(color: MyColors.black3),
                        ),
                        SizedBox(width: 10),
                        ctr.products.isEmpty
                            ? Text('')
                            : Text(
                                Utils.numberFormat(number: ctr.totalAmount.value),
                                style: MyTextStyles.f18_bold.copyWith(color: MyColors.black3),
                              ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ctr.products.isEmpty
                        ? Center(child: Text('목록이 비어 있습니다', style: MyTextStyles.f18_bold.copyWith(color: MyColors.black3)))
                        : ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              ListView.separated(
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
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                    Obx(() => ctr.allowCallAPI.isTrue
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SizedBox.shrink()),
                  ],
                ),
              ),
            );
    });
  }
}
