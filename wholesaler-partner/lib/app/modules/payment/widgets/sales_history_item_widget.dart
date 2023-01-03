import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/payment/tab2_order_history/controller/tab2_order_history_controller.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/utils/utils.dart';

class SalesHistoryItem extends GetView {
  Tab2_OrderHistoryController ctr = Get.put(Tab2_OrderHistoryController());

  RxBool isVisible = false.obs;
  int index;
  SalesHistoryItem({required this.index});
  // SalesHistoryItem({required this.orderHistoryModelCollapsed, required this.orderHistoryExpandedList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // collapsed part
          InkWell(
            onTap: () async {
              // ctr.expandPressed(orderHistoryModelCollapsed.date!);
              await ctr.expandPressed(index: index, date: ctr.orderHistoriesCollapsed[index].date!);
              isVisible.toggle();
            },
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ctr.orderHistoriesCollapsed[index].date!,
                      style: MyTextStyles.f16.copyWith(color: MyColors.black3),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'sales_price'.tr,
                          style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
                        ),
                        SizedBox(width: 20),
                        Text(
                          Utils.numberFormat(number: ctr.orderHistoriesCollapsed[index].sale_amount!) + '원',
                          style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),

          // Expanded part
          Obx(
            () => Visibility(
              visible: isVisible.value,
              child: isVisible.value
                  ? DataTable(
                      headingTextStyle: MyTextStyles.f14.copyWith(color: MyColors.black2),
                      columnSpacing: 20,
                      horizontalMargin: 0,
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text('품목'),
                        ),
                        DataColumn(
                          label: Text('옵션'),
                        ),
                        DataColumn(
                          label: Text('수량'),
                        ),
                        DataColumn(
                          label: Text('금액'),
                        ),
                      ],
                      // Expanded content
                      rows: <DataRow>[
                        for (int jj = 0; jj < ctr.orderHistoriesExpanded[index].length; jj++)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(
                                SizedBox(
                                  width: 120,
                                  child: Text(ctr.orderHistoriesExpanded[index][jj].product_name!),
                                ),
                              ),
                              DataCell(Text(ctr.orderHistoriesExpanded[index][jj].option_name!)),
                              DataCell(Text(ctr.orderHistoriesExpanded[index][jj].qty!.toString())),
                              DataCell(Text(Utils.numberFormat(number: ctr.orderHistoriesExpanded[index][jj].sub_sale_amount!))),
                            ],
                          ),
                      ],
                    )
                  : LoadingWidget(),
            ),
          ),
        ],
      ),
    );
  }

  ExpandablePanel({required Text header, required Text collapsed, required Text expanded, required bool tapHeaderToExpand, required bool hasIcon}) {}
}
