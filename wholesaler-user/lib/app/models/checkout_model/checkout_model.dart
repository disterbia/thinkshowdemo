import 'package:get/state_manager.dart';

import 'checkout_list.dart';
import 'iamport_info.dart';
import 'user_info.dart';

class Cart2CheckoutModel {
  int? checkoutId;
  UserInfo? userInfo;
  List<CheckoutList>? checkoutList;
  RxInt deliveryCost;
  RxInt onlyProductPrice;
  RxInt totalProductAmount;
  IamportInfo? iamportInfo;
  RxInt discountPrice; // discount price or in other words usedPoints
  int? usedPoints;

  Cart2CheckoutModel({
    this.checkoutId,
    this.userInfo,
    this.checkoutList,
    required this.deliveryCost,
    required this.onlyProductPrice,
    required this.totalProductAmount,
    this.iamportInfo,
    required this.discountPrice,
    this.usedPoints,
  });

  factory Cart2CheckoutModel.fromJson(Map<String, dynamic> json) => Cart2CheckoutModel(
        discountPrice: 0.obs,
        checkoutId: json['checkout_id'] as int?,
        userInfo: json['user_info'] == null ? null : UserInfo.fromJson(json['user_info'] as Map<String, dynamic>),
        checkoutList: (json['checkout_list'] as List<dynamic>?)?.map((e) => CheckoutList.fromJson(e as Map<String, dynamic>)).toList(),
        deliveryCost: (json['delivery_cost'] as int).obs,
        onlyProductPrice: (json['total_product_amount'] as int).obs,
        totalProductAmount: (json['pay_amount'] as int).obs,
        iamportInfo: json['iamport_info'] == null ? null : IamportInfo.fromJson(json['iamport_info'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'checkout_id': checkoutId,
        'user_info': userInfo?.toJson(),
        'checkout_list': checkoutList?.map((e) => e.toJson()).toList(),
        'delivery_cost': deliveryCost,
        'total_product_amount': onlyProductPrice,
        'pay_amount': totalProductAmount,
        'iamport_info': iamportInfo?.toJson(),
      };
}
