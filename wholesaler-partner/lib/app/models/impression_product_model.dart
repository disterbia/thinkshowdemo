import 'package:wholesaler_user/app/models/product_model.dart';

class ImpressionProductModel {
  final int expressionCount;
  final int clickCount;
  final int likeCount;
  final int totalCost;
  final int clickRate;
  final int orderRate;
  final Product productInformation;

  ImpressionProductModel(
      {required this.expressionCount,
      required this.clickCount,
      required this.likeCount,
      required this.totalCost,
      required this.clickRate,
      required this.orderRate,
      required this.productInformation});
}
