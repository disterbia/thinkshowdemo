import 'package:wholesaler_user/app/models/address_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/user_model.dart';

class OrderOrReview {
  int id;
  List<Product> products;
  Address address;
  DateTime date;
  String orderNumber;
  User user;
  String paymentMethod;
  int? totalPayAmount;
  int deliveryFee;
  int pointUsed;
  String? delivery_invoice_number;
  String? delivery_company_name;
  int? product_amount; // 상품 총 가격
  OrderOrReview({
    required this.id,
    required this.user,
    required this.products,
    required this.address,
    required this.date,
    required this.orderNumber,
    required this.paymentMethod,
    this.totalPayAmount,
    required this.deliveryFee,
    required this.pointUsed,
    this.product_amount,
    this.delivery_company_name,
    this.delivery_invoice_number
  });
}
