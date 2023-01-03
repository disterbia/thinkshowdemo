class Order {
	int? productOptionId;
	int? qty;

	Order({this.productOptionId, this.qty});

	factory Order.fromJson(Map<String, dynamic> json) => Order(
				productOptionId: json['product_option_id'] as int?,
				qty: json['qty'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'product_option_id': productOptionId,
				'qty': qty,
			};
}
