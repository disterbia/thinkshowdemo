import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/order_details/controllers/order_details_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/widgets/order_item_listview.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/widgets/order_top_detail_widget.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  OrderDetailsController ctr = Get.put(OrderDetailsController());
  int orderId;
  OrderDetailsView({required this.orderId});

  init() {
    ctr.getData(orderId);
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: true, title: '주문조회 상세'),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item list view
          Obx(
            () => ctr.order.value.id != -1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OrderTopDetailWidget(
                        order: ctr.order.value,
                        isHideDetailInfoBtn: true,
                      ),
                      OrderItemListView(
                        isReviewPage: false,
                        order: ctr.order.value,
                      ),
                      Container(
                        height: 6,
                        color: MyColors.grey1,
                      ),
                      // 받는 사람 정보
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _header('받는 사람 정보'),
                            SizedBox(height: 10),
                            Divider(height: 1),
                            SizedBox(height: 10),
                            _tile('gift_recipient'.tr, ctr.order.value.user.userName),
                            SizedBox(height: 10),
                            _tile('contact'.tr, ctr.order.value.user.phoneNumber.toString()),
                            SizedBox(height: 10),
                            _tile(
                              'address'.tr,
                              ctr.order.value.address.address + ' \n' + ctr.order.value.address.addressDetail,
                            ),
                            SizedBox(height: 10),
                            _tile('요청사항', ctr.order.value.address.requestMessage),
                            SizedBox(height: 50),
                            _header('Payment_info'.tr),
                            SizedBox(height: 10),
                            Divider(height: 1),
                            SizedBox(height: 10),
                            _spaceBetweenTile('payment_method'.tr, ctr.order.value.paymentMethod),
                            SizedBox(height: 10),
                            Divider(height: 1),
                            SizedBox(height: 20),
                            _spaceBetweenTile('총 상품 금액', Utils.numberFormat(number: ctr.order.value.product_amount!, suffix: '원')),
                            SizedBox(height: 10),
                            _spaceBetweenTile('총 결제 금액', Utils.numberFormat(number: ctr.order.value.totalPayAmount!, suffix: '원')),
                            SizedBox(height: 10),
                            _spaceBetweenTile('totall_shipping_fee'.tr, Utils.numberFormat(number: ctr.order.value.deliveryFee, suffix: '원')),
                            SizedBox(height: 10),
                            _spaceBetweenTile('point'.tr, '-' + Utils.numberFormat(number: ctr.order.value.pointUsed, suffix: '원')),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(child: LoadingWidget()),
          ),

          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _spaceBetweenTile(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label), Text(value)],
    );
  }

  Widget _tile(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: MyTextStyles.f14.copyWith(color: MyColors.black5),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: MyTextStyles.f14.copyWith(color: MyColors.black5),
          ),
        ),
      ],
    );
  }

  Widget _header(String title) {
    return Text(
      title,
      style: MyTextStyles.f16.copyWith(color: MyColors.black5),
    );
  }

  Widget _button() {
    return CustomButton(
      onPressed: () {},
      text: 'Delivery_completed'.tr,
      backgroundColor: MyColors.grey1,
      borderColor: MyColors.grey1,
      textColor: MyColors.black,
      width: Get.width,
    );
  }
}
