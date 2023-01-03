/// [OrderHistoryCollapsedModel]: when 주문금액 is collapsed
class OrderHistoryCollapsedModel {
  String? date;
  int? sale_amount;

  OrderHistoryCollapsedModel({required this.date, required this.sale_amount});
}

/// [OrderHistoryExpandedModel]: when 주문금액 is expanded
class OrderHistoryExpandedModel {
  String? product_name;
  String? option_name;
  int? qty;
  int? sub_sale_amount;

  OrderHistoryExpandedModel({required this.product_name, required this.option_name, required this.qty, required this.sub_sale_amount});

  OrderHistoryExpandedModel.fromJson(var json) {
    product_name = json['product_name'];
    option_name = json['option_name'];
    qty = json['qty'];
    sub_sale_amount = json['sale_amount'];
  }
}
