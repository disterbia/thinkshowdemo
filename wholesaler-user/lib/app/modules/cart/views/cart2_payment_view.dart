import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/checkout_model/checkout_model.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart2_payment_controller.dart';
import 'package:wholesaler_user/app/modules/cart/widgets/cart_items_list_widget.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/custom_field.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';

class Cart2PaymentView extends GetView {
  Cart2PaymentController ctr = Get.put(Cart2PaymentController());

  Cart2PaymentView(Cart2CheckoutModel cart2checkoutModel) {
    //print onlyPrice
    ctr.init(cart2checkoutModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(isBackEnable: true, title: '결제'),
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Obx(
            () => ctr.cartItems.length > 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CartItemsList(isCart1Page: false, cartItems: ctr.cartItems),
                  )
                : SizedBox.shrink(),
          ),
          Divider(thickness: 10, color: MyColors.grey3),
          SizedBox(height: 20),
          // Bottom Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 배송정보
                  _titleBuilder('배송정보'),
                  SizedBox(height: 10),
                  _deliveryAddressCheckbox(),
                  SizedBox(height: 20),
                  // 주문하시는 분
                  _titleBuilder('주문하시는 분'),
                  SizedBox(height: 6),
                  CustomTextField(
                    controller: ctr.nameController,
                    labelText: '이름을 입력해주세요.',
                  ),
                  SizedBox(height: 15),
                  // 주소
                  _titleBuilder('주소'),
                  SizedBox(height: 6),
                  // 우편번호
                  Obx(
                    () => CustomField(
                      buttonText: ctr.isUseNewAddress.isTrue ? '주소 검색' : null,
                      fieldController: ctr.address1ZipCodeController,
                      fieldText: '우편번호',
                      readOnly: true,
                      onTap: () => ctr.searchAddressBtnPressed(),
                    ),
                  ),
                  SizedBox(height: 10),
                  // 주소 입력
                  CustomTextField(
                    readOnly: true,
                    controller: ctr.address2Controller,
                    labelText: '주소 입력',
                  ),
                  SizedBox(height: 10),
                  // 상세주소
                  CustomTextField(
                    controller: ctr.address3Controller,
                    labelText: '주소 상세',
                  ),
                  SizedBox(height: 15),
                  // 전화번호
                  _titleBuilder('휴대폰 번호'),
                  SizedBox(height: 6),
                  _phoneNumberBody(),
                  SizedBox(height: 15),
                  // 요청사항
                  _titleBuilder('요청사항'),
                  SizedBox(height: 6),
                  // 요청사항
                  CustomTextField(
                    controller: ctr.requestController,
                    labelText: '요청사항을 입력해주세요.',
                  ),
                  Divider(color: MyColors.grey3, thickness: 1, height: 40),
                  // 적립금
                  Row(
                    children: [
                      _titleBuilder('적립금'),
                      Spacer(),
                      Obx(
                        () => Text(
                          '사용가능 ' + Utils.numberFormat(number: ctr.cart2checkoutModel.value.userInfo!.point.value, suffix: 'P'),
                          style: MyTextStyles.f12.copyWith(color: MyColors.grey2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  CustomField(
                    fieldText: '0 원',
                    fieldController: ctr.pointController,
                    isTextKeyboard: false,
                    buttonText: '사용',
                    onTap: () => ctr.usePointBtnPressed(),
                  ),
                  SizedBox(height: 20),
                  // 결제정보
                  _titleBuilder('결제정보'),
                  Divider(color: MyColors.grey3, thickness: 1, height: 20),
                  // 주문 상품

                  _twoSideText('주문 상품', ctr.cart2checkoutModel.value.onlyProductPrice.value),
                  SizedBox(height: 15),
                  // 할인 / 부가결제
                  Obx(
                    () => _twoSideText('할인 / 부가결제', ctr.cart2checkoutModel.value.discountPrice.value),
                  ),
                  SizedBox(height: 15),
                  // 배송비
                  Obx(
                    () => _twoSideText('배송비', ctr.cart2checkoutModel.value.deliveryCost.value),
                  ),
                  SizedBox(height: 15),
                  // 경제금액
                  _totalPrice(),
                  SizedBox(height: 30),
                  _paymentButton(),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleBuilder(String title) {
    return Text(
      title,
      style: MyTextStyles.f16.copyWith(color: MyColors.black5),
    );
  }

  Widget _deliveryAddressCheckbox() {
    return Obx(
      () => Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(activeColor: MyColors.primary, value: !ctr.isUseNewAddress.value, onChanged: (value) => ctr.checkboxPressed()),
          ),
          SizedBox(width: 6),
          Text('회원정보와 동일'),
          SizedBox(width: 15),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(activeColor: MyColors.primary, value: ctr.isUseNewAddress.value, onChanged: (value) => ctr.checkboxPressed()),
              ),
              SizedBox(width: 6),
              Text('새로운 배송지'),
            ],
          )
        ],
      ),
    );
  }

  Widget _productImage(String imageUrl) {
    return ClipRRect(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 35,
        height: 35,
        fit: BoxFit.fill,
        // placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      borderRadius: BorderRadius.circular(50),
    );
  }

  Widget _phoneNumberBody() {
    return SizedBox(
      width: Get.width - 20,
      child: Column(
        children: [
          Row(
            children: [
              // phone part 1: ex) 010
              Expanded(
                child: CustomTextField(keyboardType: TextInputType.number,
                  focusNode: ctr.focusNode1,
                  onChanged: (value) {
                    if (value.length == 6) {
                      FocusScope.of(Get.context!).requestFocus(ctr.focusNode2);
                    }
                  },
                  controller: ctr.phoneFirstPartController,
                  labelText: '',
                ),
              ),
              Text('  -  '),
              // phone part 2: ex) 1234
              Expanded(
                child: CustomTextField(keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 6) {
                      FocusScope.of(Get.context!).requestFocus(ctr.focusNode3);
                    }
                  },
                  focusNode: ctr.focusNode2,
                  controller: ctr.phoneSecondPartController,
                  labelText: '',
                ),
              ),
              Text('  -  '),
              // phone part 3: ex) 5678
              Expanded(
                  child: CustomTextField(keyboardType: TextInputType.number,
                focusNode: ctr.focusNode3,
                controller: ctr.phoneThirdPartController,
                labelText: '',
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget _twoSideText(String title, int price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: MyTextStyles.f14.copyWith(color: MyColors.black5),
        ),
        Text(
          Utils.numberFormat(number: price, suffix: '원'),
          style: MyTextStyles.f14.copyWith(color: MyColors.black5),
        )
      ],
    );
  }

  Widget _totalPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '결제금액',
          style: MyTextStyles.f16,
        ),
        Obx(
          () => Text(
            Utils.numberFormat(number: ctr.cart2checkoutModel.value.totalProductAmount.value, suffix: '원'),
            style: MyTextStyles.f16.copyWith(color: MyColors.red),
          ),
        ),
      ],
    );
  }

  Widget _paymentButton() {
    return CustomButton(
      width: Get.width,
      onPressed: () => ctr.paymentBtnPressed(),
      text: '결제하기',
    );
  }
}
