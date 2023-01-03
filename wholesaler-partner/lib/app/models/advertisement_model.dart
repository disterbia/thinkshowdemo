import 'dart:math';

import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_user/app/models/product_model.dart';

class Advertisement {
  AdType adtype;
  DateTime applyDate;
  String applyStatus;
  int fee;
  DateTime startDate;
  DateTime endDate;
  Product product;
  AdPaymentStatus paymentStatus;
  Advertisement(
      {required this.adtype,
      required this.applyDate,
      required this.applyStatus,
      required this.fee,
      required this.startDate,
      required this.endDate,
      required this.product,
      required this.paymentStatus});

  // static Advertisement dummy() {
  //   List<Advertisement> ads = [
  //     Advertisement(
  //         adtype: AdType.R,
  //         applyDate: DateTime.now(),
  //         applyStatus: 'applyStatus',
  //         fee: 15000,
  //         startDate: DateTime.now(),
  //         endDate: DateTime.now(),
  //         product: Product.dummyType14(),
  //         paymentStatus: AdPaymentStatus.notPaid),
  //   ];
  //   return ads[Random().nextInt(ads.length)];
  // }
}
