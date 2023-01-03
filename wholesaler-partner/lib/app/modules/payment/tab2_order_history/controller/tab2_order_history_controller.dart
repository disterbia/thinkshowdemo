import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/modules/payment/models/order_history_model.dart';

class Tab2_OrderHistoryController extends GetxController {
  final pApiProvider _apiProvider = pApiProvider();
  RxList<int> expandedIndexes = <int>[].obs;

  RxList<OrderHistoryCollapsedModel> orderHistoriesCollapsed = <OrderHistoryCollapsedModel>[].obs;
  RxList<List<OrderHistoryExpandedModel>> orderHistoriesExpanded = <List<OrderHistoryExpandedModel>>[].obs;

  Future<void> expandPressed({required int index, required String date}) async {
    orderHistoriesExpanded[index] = await _apiProvider.getPaymentTab2_OrderHistory(date);
  }

  /// why initialize? ex: we have 3 OrderHistoryCollapsedModel -> initialize OrderHistoryExpandedModel = 3
  /// -> then when clicked on index 2 in expandable list, put in inside OrderHistoryExpandedModel[1]
  initOrderHistoriesExpanded(int length) {
    List<OrderHistoryExpandedModel> dummy = [];
    for (int i = 0; i < length; i++) {
      orderHistoriesExpanded.add(dummy);
    }
  }
}
