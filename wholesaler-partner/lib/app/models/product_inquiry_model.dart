import 'dart:math';

import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/user_model.dart';

class ProductInquiry {
  Product product;
  String question; // 사용자 질문, 문의
  String? answer; // 관리자 답변
  DateTime date; // 문의 날짜
  User user;
  ProductInquiry({
    required this.product,
    required this.question,
    required this.date,
    required this.user,
    this.answer,
  });

  // static ProductInquiry dummy() {
  //   List<ProductInquiry> inquiries = [
  //     ProductInquiry(
  //       product: Product.dummyType8(),
  //       question: "I want to cancel my order.",
  //       date: DateTime.now(),
  //       user: User.dummy2(),
  //     ),
  //     ProductInquiry(
  //       product: Product.dummyType8(),
  //       question: "When can I get the product?",
  //       date: DateTime.now().subtract(const Duration(days: 6)),
  //       user: User.dummy2(),
  //     ),
  //     ProductInquiry(
  //       product: Product.dummyType8(),
  //       question: "When can I get the product?",
  //       date: DateTime.now().subtract(const Duration(days: 20)),
  //       user: User.dummy2(),
  //     ),
  //     ProductInquiry(
  //       product: Product.dummyType8(),
  //       question: "When can I get the product?",
  //       date: DateTime.now().subtract(const Duration(days: 50)),
  //       user: User.dummy2(),
  //     ),
  //   ];
  //   return inquiries[Random().nextInt(inquiries.length)];
  // }
}
