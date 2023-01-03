import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';

class Cart {
  List<Product> products;
  Store store;
  Cart({required this.store, required this.products});
}
