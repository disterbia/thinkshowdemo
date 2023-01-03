import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart2_payment_view.dart';
import 'package:wholesaler_user/app/modules/cart/widgets/cart_items_list_widget.dart';
import 'package:wholesaler_user/app/modules/cart/widgets/circular_checkbox.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Cart1ShoppingBasketView extends GetView {
  Cart1ShoppingBasketController ctr = Get.put(Cart1ShoppingBasketController());
  Cart1ShoppingBasketView();

  init() {
    ctr.init();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(isBackEnable: true, title: '장바구니'),
      body: Obx(()=> ctr.isLoading.value? LoadingWidget(): body()),
    );
  }

  Widget body() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  _selectAllCheckbox(),
                  Spacer(),
                  _deleteTextButtons(),
                ],
              ),
            ),
            SizedBox(height: 12),
            Divider(thickness: 10, color: MyColors.grey3),
            // empty cart
            Obx(() => ctr.cartItems.isEmpty
                ? Column(
                    children: [
                      SizedBox(height: 40),
                      Text('상품 없음'),
                    ],
                  )
                : SizedBox.shrink()),
            SizedBox(height: 15),
            // Cart
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CartItemsList(isCart1Page: true, cartItems: ctr.cartItems),
            ),
            Divider(thickness: 10, color: MyColors.grey3),
            SizedBox(height: 15),
            _bottomSection(),

            SizedBox(height: 50),
            _paymentButton(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _selectAllCheckbox() {
    return Row(
      children: [
        Obx(
          () => CircularCheckbox(
            isChecked: ctr.isSelectAllChecked.value,
            onChanged: (bool value) => ctr.SelectAllCheckboxOnChanged(value),
          ),
        ),
        SizedBox(width: 10),
        Text(
          '전체선택',
          style: MyTextStyles.f16.copyWith(color: MyColors.black3),
        ),
        SizedBox(width: 5),
        Obx(
          () => Text(
            '( ${ctr.getTotalSelectedProducts()} / ${ctr.getNumberProducts()} )',
            style: MyTextStyles.f12.copyWith(color: MyColors.black1),
          ),
        ),
      ],
    );
  }

  Widget _deleteTextButtons() {
    return Row(
      children: [
        TextButton(
          onPressed: () => ctr.cartItems.isEmpty
              ? mSnackbar(message: "상품이 없습니다.")
              : ctr.deleteSelectedProducts(),
          child: Text(
            '선택삭제',
            style: MyTextStyles.f14.copyWith(color: MyColors.black3),
          ),
        ),
        SizedBox(width: 15),
        TextButton(
          onPressed: () => ctr.cartItems.isEmpty
              ? mSnackbar(message: "상품이 없습니다.")
              : ctr.deleteAllProducts(),
          child: Text(
            '전체삭제',
            style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
          ),
        ),
      ],
    );
  }

  Widget _bottomSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text('selected_products_num'.tr),
              Spacer(),
              Obx(() => Text(ctr.getTotalSelectedProducts().toString() + '개')),
            ],
          ),
          SizedBox(height: 25),
          Row(
            children: [
              Text('결제 금액'),
              Spacer(),
              Obx(
                () => Text(Utils.numberFormat(
                    number: ctr.totalPaymentPrice.value, suffix: '원')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paymentButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (ctr.getTotalSelectedProducts() != 0) {
            await ctr.postOrderCheckout();
          } else {
            mSnackbar(message: '상품을 선택해주세요.');
          }
        },
        child: Text(
          '구매하기',
          style: MyTextStyles.f14.copyWith(color: MyColors.white),
        ),
      ),
    );
  }
}
