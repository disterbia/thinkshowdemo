import 'package:wholesaler_partner/app/models/sale_product_list_model.dart';

class SaleProductModel {
  final int productTotalCount;
  final List<SaleProductListModel> products;

  SaleProductModel({required this.productTotalCount, required this.products});

  factory SaleProductModel.fromJson(Map<String, dynamic> data) {
    return SaleProductModel(
        productTotalCount: data['total_count'],
        products:
            SaleProductListModel.fromJsonList(data['wholesale_report_list']));
  }
}
