import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/size_category.dart';

class ProductBodySizeModel {
  int clothMainCategory;
  RxBool isSelected;
  String size;
  SizeCategory sizeCategory;
  ProductBodySizeModel({required this.size, required this.clothMainCategory, required this.sizeCategory, required this.isSelected});
}
