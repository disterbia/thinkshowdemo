import 'package:wholesaler_user/app/models/product_model.dart';

class ExposureAdModel {
  int ads_application_id;
  String date;
  List<Product> adProducts;

  ExposureAdModel({required this.date, required this.adProducts, required this.ads_application_id});
}
