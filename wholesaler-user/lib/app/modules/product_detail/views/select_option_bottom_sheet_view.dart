import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/dropdown_widget.dart';
import 'package:wholesaler_user/app/widgets/product/quantity_plus_minus_widget.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

Future<dynamic> SelectOptionBottomSheet() {
  ProductDetailController ctr = Get.put(ProductDetailController());

  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // option title, option drop down
                Text(
                  '옵션',
                  style: MyTextStyles.f14.copyWith(color: MyColors.black3),
                ),
                SizedBox(height: 5),
                Obx(
                  () => Container(
                    child: mOptionDropDownButton(
                      label: '옵션을 선택해주세요',
                      options: ctr.product.value.options!,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // quantity
                Text(
                  '수량',
                  style: MyTextStyles.f14.copyWith(color: MyColors.black3),
                ),
                SizedBox(height: 5),
                Obx(
                  () => QuantityPlusMinusWidget(
                    quantity: ctr.product.value.quantity!.value,
                    onTap: (isRightTapped) {
                      print('isRightTapped $isRightTapped');
                      if (isRightTapped) {
                        ctr.product.value.quantity!.value = ctr.product.value.quantity!.value + 1;
                        ctr.UpdateTotalPrice();
                      } else {
                        if (ctr.product.value.quantity!.value > 1) {
                          ctr.product.value.quantity!.value = ctr.product.value.quantity!.value - 1;
                          ctr.UpdateTotalPrice();
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Divider(thickness: 1, color: MyColors.grey1),
                SizedBox(height: 20),
                // total price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Text(
                      '총 금액',
                      style: MyTextStyles.f14.copyWith(color: MyColors.black3),
                    ),
                    Spacer(),
                    Obx(
                      () => Text(
                        Utils.numberFormat(number: ctr.totalPrice.value),
                        style: MyTextStyles.f18_bold.copyWith(color: MyColors.red),
                      ),
                    ),
                    Text(
                      '원',
                      style: MyTextStyles.f16.copyWith(color: MyColors.black3),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                TwoButtons(
                  leftBtnText: 'shopping_basket'.tr,
                  rightBtnText: '구매하기',
                  lBtnOnPressed: () => ctr.purchaseBtnPressed(isDirectBuy: false),
                  rBtnOnPressed: () => ctr.purchaseBtnPressed(isDirectBuy: true),
                ),
              ],
            ),
          ),
        );
      });
}
