import 'order.dart';

class Cart1OrdersModel {
	List<Order>? orders;

	Cart1OrdersModel({this.orders});

	factory Cart1OrdersModel.fromJson(Map<String, dynamic> json) {
		return Cart1OrdersModel(
			orders: (json['orders'] as List<dynamic>?)
						?.map((e) => Order.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'orders': orders?.map((e) => e.toJson()).toList(),
			};
}
