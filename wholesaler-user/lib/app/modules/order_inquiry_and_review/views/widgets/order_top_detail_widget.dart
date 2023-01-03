import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/order_model.dart';
import 'package:wholesaler_user/app/modules/order_details/views/order_details_view.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';

class OrderTopDetailWidget extends StatelessWidget {
  final OrderOrReview order;
  final bool isHideDetailInfoBtn;
  const OrderTopDetailWidget({required this.order, this.isHideDetailInfoBtn = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 75,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MyDimensions.radius)), color: MyColors.grey7),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              rowInformation(
                'order_date'.tr,
                DateFormat('yyyy-MM-dd').format(order.date),
              ),
              SizedBox(height: 10),
              rowInformation('Order_Number'.tr, order.orderNumber),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: isHideDetailInfoBtn
                    ? SizedBox.shrink()
                    : CustomButton(
                        text: '상세보기',
                        textColor: MyColors.black2,
                        backgroundColor: MyColors.grey1,
                        borderColor: MyColors.grey1,
                        fontSize: 12,
                        onPressed: () {
                          Get.to(() => OrderDetailsView(
                                orderId: order.id,
                              ));
                        },
                      ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget rowInformation(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 60,
          child: Text(
            label,
            style: MyTextStyles.f12.copyWith(color: MyColors.grey2),
          ),
        ),
        Text(
          value,
          style: MyTextStyles.f12.copyWith(color: MyColors.black2),
        )
      ],
    );
  }
}
