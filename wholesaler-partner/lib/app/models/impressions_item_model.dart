import 'package:wholesaler_partner/app/models/impression_product_model.dart';

class ImpressionItemModel {
  final String date;
  final String cost;
  final List<ImpressionProductModel> products;

  ImpressionItemModel(
      {required this.date, required this.cost, required this.products});
}
