import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:wholesaler_partner/app/modules/payment/controllers/payment_controller.dart';
import 'package:wholesaler_partner/app/modules/payment/tab1_payment_view/view/tab1_payment_view.dart';
import 'package:wholesaler_partner/app/modules/payment/tab2_order_history/view/tab2_order_history.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/text_button.dart';

import '../../../widgets/loading_widget.dart';

///정산
class PaymentView extends GetView {
  PaymentController ctr = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppbar(isBackEnable: true, title: '정산'),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _topTwoCards(),
                  ],
                ),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.white,
                title: _tabs(),
              ),
            ];
          },
          body: _tabViewBody(),
        ),
      ),
    );
  }

  _tabs() {
    return TabBar(
      labelColor: Colors.black,
      indicatorColor: Colors.black,
      tabs: [
        Tab(text: '정산'),
        Tab(text: '주문금액'),
      ],
    );
  }

  _topTwoCards() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: mTextButton.icon(
                text: '${ctr.year.value}.${ctr.month.value}',
                icon: Icons.keyboard_arrow_down_outlined,
                onPressed: () async {
                  showMonthPicker(
                    context: Get.context!,
                    firstDate: DateTime(DateTime.now().year - 10, 1),
                    lastDate: DateTime(DateTime.now().year, DateTime.now().month),
                    initialDate: DateTime.now(),
                    locale: Locale("ko"),
                  ).then((date) async {
                    if (date != null) {
                      ctr.month.value = date.month.toInt().toString();
                      ctr.year.value = date.year.toString();
                      await ctr.getPayment();
                    }
                  });
                },
              ),
            ),
          ),
          // TOP two containers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => ctr.isLoading.value
                  ? LoadingWidget()
                  : Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 91,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.black26),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Text(ctr.month.value + '월 ' + '정산 금액'),
                                ),
                                SizedBox(height: 4),
                                Text('${ctr.sumAmount}원'),
                                SizedBox(height: 4),
                                Text(
                                  'VAT_included'.tr,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 91,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.black26),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('sales_price'.tr),
                                SizedBox(height: 4),
                                Text('${ctr.saleSumAmount}원'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _tabViewBody() {
    return TabBarView(
      children: [
        Tab1_PaymentView(),
        Tab2_OrderHistoryView(),
      ],
    );
  }
}
