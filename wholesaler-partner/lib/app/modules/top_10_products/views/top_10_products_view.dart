import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/top_10_products/controllers/top_10_products_controller.dart';
import 'package:wholesaler_partner/app/modules/top_10_products/views/top_10_item_widget.dart';
import 'package:wholesaler_partner/app/widgets/appbar_widget.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

class Top10ProductsView extends GetView<Top10ProductsController> {
  Top10ProductsController ctr = Get.put(Top10ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          height: 50.0,
          width: double.maxFinite,
          child: ElevatedButton(
            onPressed: ctr.addProductManual,
            child: Text('저장'),
          ),
        ),
      ),
      appBar: CustomAppbar(isBackEnable: false, hasHomeButton: true, title: '우리매장 TOP10'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 16),
            // 추천상품 자동등록 Button
            TwoButtons(
              leftBtnText: '베스트 상품 자동등록',
              rightBtnText: '베스트 상품 등록',
              lBtnOnPressed: ctr.getBestProductsRecommended,
              rBtnOnPressed: ctr.productManual,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'top'.tr,
                  style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                ),
                SizedBox(width: 22),
                Text(
                  'delete'.tr,
                  style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                ),
                SizedBox(width: 22),
                Text(
                  'move'.tr,
                  style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                ),
                SizedBox(width: 12),
              ],
            ),
            Expanded(
              child: Obx(
                () => ctr.isLoading.value
                    ? LoadingWidget()
                    : ReorderableListView(
                        onReorder: (oldIndex, newIndex) {
                          ctr.dragAndDropProduct(oldIndex, newIndex);
                        },
                        children: ctr.products
                            .map(
                              (product) => Container(
                                key: ValueKey(product),
                                child: Top10Item(product: product),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
