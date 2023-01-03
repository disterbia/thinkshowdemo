import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart2_payment_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/order_inquiry_and_review_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Payment extends StatelessWidget {
  Cart2PaymentController cart2Ctr = Get.put(Cart2PaymentController());

  Payment();
  @override
  Widget build(BuildContext context) {
    // print(
    //     'payment build: cart2Ctr.cart2checkoutModel.value.userInfo!.email! = ${cart2Ctr.cart2checkoutModel.value.userInfo!.email}');
    return IamportPayment(
        appBar: new AppBar(
          title: new Text('띵쇼마켓 결제'),
        ),
        /* 웹뷰 로딩 컴포넌트 */
        initialChild: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/shared_images_icons/login_logo.png',
                  width: 84,
                  height: 84,
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        /* [필수입력] 가맹점 식별코드 */
        userCode: cart2Ctr.cart2checkoutModel.value.iamportInfo!.iamportId!,
        /* [필수입력] 결제 데이터 */
        data: PaymentData(
            pg: cart2Ctr.cart2checkoutModel.value.iamportInfo!.pg!, // PG사
            payMethod: 'card', // 결제수단
            name: '아임포트 결제데이터 분석', // 주문명
            merchantUid: cart2Ctr
                .cart2checkoutModel.value.iamportInfo!.merchantUid!
                .toString(), // 주문번호
            // merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
            amount: cart2Ctr
                .cart2checkoutModel.value.totalProductAmount.value, // 결제금액
            buyerName: cart2Ctr.nameController.text, // 구매자 이름
            buyerTel: cart2Ctr.phoneFirstPartController.text +
                cart2Ctr.phoneSecondPartController.text +
                cart2Ctr.phoneThirdPartController.text, // 구매자 연락처
            buyerEmail:
                cart2Ctr.cart2checkoutModel.value.userInfo!.email!, // 구매자 이메일
            buyerAddr: cart2Ctr.address2Controller.text, // 구매자 주소
            buyerPostcode: cart2Ctr.address1ZipCodeController.text, // 구매자 우편번호
            appScheme: 'wholesaleruser', // 앱 URL scheme
            displayCardQuota: [2, 3] //결제창 UI 내 할부개월수 제한
            ),
        /* [필수입력] 콜백 함수 */
        callback: (Map<String, dynamic> result) {
         // print('payment result $result');
          if (result['imp_success'] == 'true') {
            cart2Ctr.paymentSuccessful(result);
          } else {
            mSnackbar(message: '결제에 실패하였습니다.');
            Get.back();
            Get.back();
          }
        });
  }
}
