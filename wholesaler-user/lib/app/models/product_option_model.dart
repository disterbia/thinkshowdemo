import 'package:wholesaler_user/app/constants/constants.dart';

class ProductOptionModel {
  int? id;
  int? product_id;
  String? name;
  String? color;
  String? size;
  int? stock_qty;
  int? add_price;
  bool? is_sold_out;

  ProductOptionModel({
    required this.id,
    required this.product_id,
    required this.name,
    required this.color,
    required this.size,
    required this.stock_qty,
    required this.add_price,
    required this.is_sold_out,
  });

  ProductOptionModel.fromJson(dynamic json) {
    id = json['id'];
    product_id = json['product_id'];
    name = json['name'];
    color = json['color'];
    size = json['size'];
    stock_qty = json['stock_qty'];
    add_price = json['add_price'];
    is_sold_out = json['is_sold_out'];
  }
}
