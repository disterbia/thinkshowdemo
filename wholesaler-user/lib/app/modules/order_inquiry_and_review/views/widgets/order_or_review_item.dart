import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/order_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/models/writable_review_info_model.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/orders_inquiry_review_controller.dart';
import 'package:wholesaler_user/app/modules/review_detail/views/review_detail_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class OrderOrReviewItem extends StatelessWidget {
  OrderInquiryAndReviewController ctr = Get.put(OrderInquiryAndReviewController());

  final int productId;
  bool isOrderDetailPage;
  bool isReviewPage;
  OrderOrReview item;

  OrderOrReviewItem({required this.productId, this.isOrderDetailPage = false, this.isReviewPage = false, required this.item});

  @override
  Widget build(BuildContext context) {
    print("-=-=--=-=-=-=-=-=-=${item}");
    return Column(
      children: [
        // _informationBox(),
        // SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ProductItemHorizontal(product: item.products[productId]),
        ),
        SizedBox(height: 10),
        // Delivery Status: 배달 상태
        _deliveryStatusBuilder(),
        SizedBox(height: 10),
        Text("송장번호 : ${item.products[productId].delivery_company_name??""}+ ${item.products[productId].delivery_invoice_number??""}"),
        isReviewPage ? _reviewPageBottomButtons() : _orderPageBottomButtons(),
      ],
    );
  }

  _reviewPageBottomButtons() {
    return WriteReviewElevatedButtion();
  }

  _orderPageBottomButtons() {
    // 결제완료, 상품준비중
    if (item.products[productId].orderStatus == OrderStatus.payFinished || item.products[productId].orderStatus == OrderStatus.preparingProduct) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            mSnackbar(message: '주문 취소는 각 상품페이지 문의하기를 통해 접수 바랍니다.', duration: 3);
          },
          child: Text(
            '취소 안내',
          ),
        ),
      );
    }

    // 배달완료
    if (item.products[productId].orderStatus == OrderStatus.deliveryFinished) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => ctr.orderSettledBtnPressed(item.products[productId].orderDetailId!),
          child: Text(
            '구매확정',
          ),
        ),
      );
    }

    // 구매확정
    if (item.products[productId].orderStatus == OrderStatus.deliveryConfirmed && !item.products[productId].isReviewWritten!) {
      return WriteReviewElevatedButtion();
    }

    // 기타: 배송시작 (아무것도 보여주지마세요)
    return SizedBox.shrink();
  }

  Widget WriteReviewElevatedButtion() {
   // print('WriteReviewElevatedButtion orderDetailId = ${item.products[productId].orderDetailId}');
   // print('WriteReviewElevatedButtion price = ${item.products[productId].price}');
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(
            () => ReviewDetailView(
              isComingFromReviewPage: isReviewPage,
              isEditing: false,
              selectedReviw: Review(
                id: -1,
                content: '',
                rating: 0,
                ratingType: ProductRatingType.star,
                date: DateTime.now(),
                createdAt: Utils.dateToString(date: DateTime.now()),
                product: item.products[productId],
                reviewImageUrl: '',
              ),
            ),
          );
        },
        child: Text(
          '리뷰쓰기',
        ),
      ),
    );
  }

  _deliveryStatusBuilder() {
    String statusMessage = '';
    if (item.products[productId].orderStatus == OrderStatus.payFinished || item.products[productId].orderStatus == OrderStatus.preparingProduct) {
      statusMessage = '상품준비중';
    } else if (item.products[productId].orderStatus == OrderStatus.deliveryStart || item.products[productId].orderStatus == OrderStatus.delivering) {
      statusMessage = '배송중';
    }else if(item.products[productId].orderStatus == OrderStatus.cancelOrder){
      statusMessage = '주문취소';
    }else if(item.products[productId].orderStatus == OrderStatus.exchangeApply){
      statusMessage = '교환신청';
    }else if(item.products[productId].orderStatus == OrderStatus.exchangeFinished){
      statusMessage='교환완료';
    }else if(item.products[productId].orderStatus == OrderStatus.returnApply){
      statusMessage = '반품신청';
    }else if(item.products[productId].orderStatus == OrderStatus.returnFinished){
      statusMessage = '반품완료';
    }
    else {
      statusMessage = '배송완료';
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/ic_delivery_truck.png',
          width: 26,
        ),
        SizedBox(width: 10),
        Text(
          '배달 상태',
          style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
        ),
        SizedBox(width: 40),
        Text(
          statusMessage,
          style: MyTextStyles.f14.copyWith(color: MyColors.black2),
        ),
      ],
    );
  }
}
