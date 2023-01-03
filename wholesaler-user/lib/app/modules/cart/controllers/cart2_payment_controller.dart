import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/cart_model.dart';
import 'package:wholesaler_user/app/models/checkout_model/checkout_list.dart';
import 'package:wholesaler_user/app/models/checkout_model/checkout_model.dart';
import 'package:wholesaler_user/app/models/checkout_model/item.dart';
import 'package:wholesaler_user/app/models/checkout_model/user_info.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/payment/payment.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/order_inquiry_and_review_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Cart2PaymentController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  int minAllawablePaymentPrice = 1000; // 최소 결제 금액 1000원

  Rx<Cart2CheckoutModel> cart2checkoutModel = Cart2CheckoutModel(discountPrice: 0.obs, onlyProductPrice: 0.obs, deliveryCost: 0.obs, userInfo: UserInfo(point: 0.obs), totalProductAmount: 0.obs).obs;

  RxList<Cart> cartItems = <Cart>[].obs;

  Cart1ShoppingBasketController c= Get.put(Cart1ShoppingBasketController());

  RxBool isUseNewAddress = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController address1ZipCodeController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController phoneFirstPartController = TextEditingController();
  TextEditingController phoneSecondPartController = TextEditingController();
  TextEditingController phoneThirdPartController = TextEditingController();
  TextEditingController requestController = TextEditingController();
  TextEditingController pointController = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  void init(Cart2CheckoutModel cart2checkoutModel) {
    this.cart2checkoutModel.value = cart2checkoutModel;

    // Ordered Products
    for (CheckoutList checkout in cart2checkoutModel.checkoutList!) {
      Store tempStore = Store(id: checkout.storeId!, name: checkout.storeName!, imgUrl: checkout.storeThumbnailImagePath != null ? checkout.storeThumbnailImagePath!.obs : null);
      List<Product> tempProducts = [];
      for (Item item in checkout.items!) {
        Product tempProduct = Product(
          id: -1,
          imgHeight: 90,
          imgWidth: 72,
          title: item.productName!,
          imgUrl: item.productThumbnailImagePath!,
          store: tempStore,
          quantity: item.qty!.obs,
          OLD_option: item.productOptionName,
          isCheckboxSelected: true.obs,
          price: item.price,
          selectedOptionAddPrice: item.addPrice,
        );
        tempProducts.add(tempProduct);
      }
      Cart cart = Cart(store: tempStore, products: tempProducts);
      cartItems.add(cart);
    }

    // Text Edit Controllers
    updateTextEditControllers(cart2checkoutModel);

    //print('cart2checkoutModel.deliveryCost! = ${cart2checkoutModel.deliveryCost}');
  }

  // 포인트 상요 button
  usePointBtnPressed() {
    //print('usePointBtnPressed called');
    if (pointController.text.isNotEmpty) {
      try {
        int tempUsedPoints = int.parse(pointController.text);
        //print('usedPoints: $tempUsedPoints');
        // check if used point is more than available point
        if (tempUsedPoints > cart2checkoutModel.value.userInfo!.point.value) {
          mSnackbar(message: '포인트 사용가능 금액을 초과하였습니다.');
        }
        // check if used point is more that product price
        else if (tempUsedPoints > (cart2checkoutModel.value.totalProductAmount.value + cart2checkoutModel.value.discountPrice.value)) {
          // print tempUsedPoints and cart2checkoutModel.value.totalProductAmountNew
          print(
              'tempUsedPoints: $tempUsedPoints and cart2checkoutModel.value.totalProductAmountNew: ${cart2checkoutModel.value.totalProductAmount.value} and cart2checkoutModel.value.discountPrice.value: ${cart2checkoutModel.value.discountPrice.value}');
          mSnackbar(message: '사용하신 포인트가 결제금액을 초과하였습니다.');
        } else {
          // Our payment gate requires at least 1000원 for successful pay. check it
          int tempTotalProductAmount = cart2checkoutModel.value.onlyProductPrice.value - tempUsedPoints + cart2checkoutModel.value.deliveryCost.value;
          // if (tempTotalProductAmount < minAllawablePaymentPrice) {
          //   mSnackbar(message: '포인트를 사용하시려면 결제금액이 $minAllawablePaymentPrice원 이상이어야 합니다.');
          //   return;
          // }
          cart2checkoutModel.value.discountPrice.value = tempUsedPoints;
          cart2checkoutModel.value.totalProductAmount.value = tempTotalProductAmount;
        }
      } catch (e) {
        mSnackbar(message: '숫자만 입력해주세요.');
        return;
      }
    }
  }

  void updateTextEditControllers(cart2checkoutModel) {
    nameController.text = isUseNewAddress.value ? '' : cart2checkoutModel.userInfo!.name!;
    // address
    address1ZipCodeController.text = isUseNewAddress.value ? '' : cart2checkoutModel.userInfo!.addressInfo!.zipCode!;
    address2Controller.text = isUseNewAddress.value ? '' : cart2checkoutModel.userInfo!.addressInfo!.address!;
    address3Controller.text = isUseNewAddress.value ? '' : cart2checkoutModel.userInfo!.addressInfo!.addressDetail!;
    // phone number
    String phoneNumber = cart2checkoutModel.userInfo!.phone!;
    phoneFirstPartController.text = isUseNewAddress.value ? '' : phoneNumber.substring(0, 3);
    phoneSecondPartController.text = isUseNewAddress.value ? '' : phoneNumber.substring(3, 7);
    phoneThirdPartController.text = isUseNewAddress.value ? '' : phoneNumber.substring(7, phoneNumber.length);
  }

  checkboxPressed() {
    isUseNewAddress.toggle();
    updateTextEditControllers(cart2checkoutModel.value);
  }

  // Call Daum Search API
  Future<void> searchAddressBtnPressed() async {
    Kpostal result;
    try {
      result = await Navigator.push(Get.context!, MaterialPageRoute(builder: (_) => KpostalView()));
    } catch (e) {
     // print('The user did not select an address. searchAddressBtnPressed error: $e');
      return;
    }
    address1ZipCodeController.text = result.postCode;
    address2Controller.text = result.address;
    // Update delivery fee. For 제주도 4,000원, for the rest of the country: free
    cart2checkoutModel.value.deliveryCost.value = await _apiProvider.getDeliveryFee(checkout_id: cart2checkoutModel.value.checkoutId!, postCode: result.postCode, address: result.address);
   // print('cart2checkoutModel.value.deliveryCost.value = ${cart2checkoutModel.value.deliveryCost.value}');

    // update totalPrice with new delivery fee
    cart2checkoutModel.value.totalProductAmount.value = cart2checkoutModel.value.onlyProductPrice.value + cart2checkoutModel.value.deliveryCost.value - cart2checkoutModel.value.discountPrice.value;

    // if new delivery fee results in totalPrice less than 1000, then remove discountPrice
    if (cart2checkoutModel.value.totalProductAmount.value < minAllawablePaymentPrice) {
      cart2checkoutModel.value.discountPrice.value = 0;
      pointController.text = '0';
      cart2checkoutModel.value.totalProductAmount.value = cart2checkoutModel.value.onlyProductPrice.value + cart2checkoutModel.value.deliveryCost.value;
    }
  }

  /// 결제하기 button
  paymentBtnPressed() {
    // check if all fields are filled
    if (nameController.text.isEmpty) {
      mSnackbar(message: '이름을 입력해주세요.');
      return;
    }
    if (address1ZipCodeController.text.isEmpty) {
      mSnackbar(message: '우편번호를 입력해주세요.');
      return;
    }
    if (address2Controller.text.isEmpty) {
      mSnackbar(message: '주소를 입력해주세요.');
      return;
    }
    if (address3Controller.text.isEmpty) {
      mSnackbar(message: '상세주소를 입력해주세요.');
      return;
    }
    if (phoneFirstPartController.text.isEmpty || phoneSecondPartController.text.isEmpty || phoneThirdPartController.text.isEmpty) {
      mSnackbar(message: '전화번호를 입력해주세요.');
      return;
    }

    Get.to(() => Payment());
  }

  Future<void> paymentSuccessful(Map<String, dynamic> result) async {
    // print(
    //     'inside paymentSuccessful.  orderer_name ${nameController.text} zipcode ${address1ZipCodeController.text} address ${address2Controller.text} address_detail ${address3Controller.text} phone ${phoneFirstPartController.text}${phoneSecondPartController.text}${phoneThirdPartController.text} request_message ${requestController.text} checkout_id ${cart2checkoutModel.value.checkoutId!}');
    // call [주문페이지] 주문 > complete API ( 결제완료 요청 ) API
    bool isSuccess = await _apiProvider.postPaymentSucessfullyFinished(
      imp_uid: result['imp_uid']!,
      merchant_uid: result['merchant_uid']!,
      use_point: cart2checkoutModel.value.discountPrice.value,
      orderer_name: nameController.text,
      zipcode: address1ZipCodeController.text,
      address: address2Controller.text,
      address_detail: address3Controller.text,
      phone: '${phoneFirstPartController.text}${phoneSecondPartController.text}${phoneThirdPartController.text}',
      request_message: requestController.text,
      checkout_id: cart2checkoutModel.value.checkoutId!,
    );

    if (isSuccess) {
      c.deleteSelectedProducts();
      // go to [주문완료] page
      Get.offAll(() => OrderInquiryAndReviewView(isBackEnable: false, hasHomeButton: true), arguments: false);
      mSnackbar(message: '결제가 완료되었습니다.');
    } else {
      mSnackbar(message: '결제에 실패했습니다.');
    }
  }
}
