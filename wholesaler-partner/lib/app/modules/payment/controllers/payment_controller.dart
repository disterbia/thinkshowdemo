import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/models/order_model.dart';
import 'package:wholesaler_partner/app/models/payment_item_model.dart';
import 'package:wholesaler_partner/app/modules/payment/models/order_history_model.dart';
import 'package:wholesaler_partner/app/modules/payment/tab2_order_history/controller/tab2_order_history_controller.dart';
import 'package:wholesaler_user/app/utils/utils.dart';

///정산
class PaymentController extends GetxController {
  Tab2_OrderHistoryController tab2_orderHistoryCtr = Get.put(Tab2_OrderHistoryController());

  List<PaymentItemModel> payments = [];
  List<OrderModel> orders = [];
  RxBool isLoading = false.obs;
  RxBool isLoadingOrders = false.obs;
  final pApiProvider _apiProvider = pApiProvider();
  String sumAmount = '';
  String saleSumAmount = '';
  RxString month = ''.obs;
  RxString year = ''.obs;

  @override
  void onInit() async {
    DateTime now = DateTime.now();
    month.value = now.month.toInt().toString();
    year.value = now.year.toString();
    await getPayment();
  }

  Future<void> getPayment() async {
    payments.clear();
    tab2_orderHistoryCtr.orderHistoriesCollapsed.clear();
    isLoading.value = true;

    await _apiProvider.getPayments(year.value, month.value).then((response) {
      sumAmount = Utils.numberFormat(
        number: response['settlement_sum_amount'],
      );
      saleSumAmount = Utils.numberFormat(number: response['sale_sum_amount']);

      // 정산 tab
      dynamic salesJson = response['settlement_list'];
      for (var i = 0; i < salesJson.length; i++) {
        PaymentItemModel payment = PaymentItemModel(
            date: salesJson[i]['date'],
            purchaseConfirmation: salesJson[i]['purchase_confirmation_amount'],
            returnAmount: salesJson[i]['refund_amount'],
            fees: salesJson[i]['margin_amount'],
            sum: salesJson[i]['sum_amount']);

        payments.add(payment);
      }

      // 주문금액 tab
      dynamic orderHistoryJson = response['sale_list'];
      for (var i = 0; i < orderHistoryJson.length; i++) {
        OrderHistoryCollapsedModel orderHistory = OrderHistoryCollapsedModel(
          date: orderHistoryJson[i]['date'],
          sale_amount: orderHistoryJson[i]['sale_amount'],
        );
        print("orderHistoryJson[i]['sale_amount'] ${orderHistoryJson[i]['sale_amount']}");
        tab2_orderHistoryCtr.orderHistoriesCollapsed.add(orderHistory);
        print('length order: ${tab2_orderHistoryCtr.orderHistoriesCollapsed.length}');
      }

      // initialize
      tab2_orderHistoryCtr.initOrderHistoriesExpanded(orderHistoryJson.length);

      print('length is ${payments.length}');
    });
    isLoading.value = false;
  }

  Future<void> getOrders() async {
    isLoadingOrders.value = true;
    orders.clear();
    await _apiProvider.getPaymentOrders('2020-20-20').then((response) {
      dynamic dynamicList = response;
      for (var i = 0; i < dynamicList.length; i++) {
        orders.add(OrderModel(name: response[i]['product_name'], option: response[i]['option_name'], quantity: response[i]['qty'], saleAmount: response[i]['sale_amount']));
      }
    });
    isLoadingOrders.value = false;
  }
}
