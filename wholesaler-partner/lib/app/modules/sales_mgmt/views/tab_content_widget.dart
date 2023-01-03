import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/modules/sales_mgmt/controllers/sales_mgmt_controller.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';

class SalesMgmtContentTabWidget extends GetView {
  SalesMgmtController ctr = Get.put(SalesMgmtController());
  SalesTab currentSalesTab;
  SalesMgmtContentTabWidget(this.currentSalesTab);
  List<String> titles = ['impressions'.tr, 'click'.tr, 'like'.tr, 'order'.tr];
  var format = NumberFormat('###,###,###,###');
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ctr.isLoading.value
          ? Center(child: LoadingWidget())
          : SingleChildScrollView(
              // controller: ctr.scrollController.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      '내 상품이 얼마나 ${titles.elementAt(currentSalesTab.index)} 되었을까?',
                      style: MyTextStyles.f16.copyWith(color: MyColors.black3),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          ctr.countOfProducts,
                          style: MyTextStyles.f18_bold.copyWith(color: MyColors.black3),
                        ),
                        Text(
                          ' 회',
                          style: MyTextStyles.f16.copyWith(color: MyColors.black3),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      '${titles.elementAt(currentSalesTab.index)}수 TOP${ctr.products.length}',
                      style: MyTextStyles.f16.copyWith(color: MyColors.black3),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ctr.products.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: ProductItemHorizontal(
                            product: ctr.products[index],
                            productNumber: ProductNumber(
                              number: index + 1,
                              backgroundColor: MyColors.numberColors.length > index ? MyColors.numberColors[index] : MyColors.numberColors[0],
                            ),
                          ),
                        );
                      },
                    ),
                    Obx(() => ctr.products.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Center(
                              child: Text(
                                '상품 없음',
                                style: MyTextStyles.f16.copyWith(color: MyColors.black3),
                              ),
                            ),
                          )
                        : SizedBox.shrink()),
                    Text(
                      'everyday_from_00_00_until_23_59'.tr,
                      style: MyTextStyles.f12.copyWith(color: MyColors.grey2),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
    );
  }
}
