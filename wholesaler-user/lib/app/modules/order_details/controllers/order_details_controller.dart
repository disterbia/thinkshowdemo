import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/address_model.dart';
import 'package:wholesaler_user/app/models/order_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/user_model.dart';

class OrderDetailsController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  Rx<OrderOrReview> order = OrderOrReview(
          id: -1,
          user: User.dummy1(),
          products: [],
          address: Address.dummy(),
          date: DateTime.now(),
          orderNumber: "orderNumber",
          paymentMethod: "paymentMethod",
      delivery_company_name:"a",
      delivery_invoice_number: "-1",
          deliveryFee: -1,
          pointUsed: -1,
          totalPayAmount: -1,
          product_amount: -1)
      .obs;

  Future<void> getData(int orderId) async {
    //print('orderid $orderId');
    order.value = await _apiProvider.getOrderDetail(orderId: orderId);
  }
}
