import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/models/impression_product_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';

import '../../../data/api_provider.dart';
import '../../../models/impressions_item_model.dart';

class AdImpressionController extends GetxController {
  RxBool isShowDetail = false.obs;
  RxBool isLoading = false.obs;
  List<String> tags = ['광고R', '광고S', '광고1ST', '광고2ST', '광고3ST', '광고4ST'];
  RxString chosenTagName = ''.obs;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final pApiProvider _apiProvider = pApiProvider();
  RxString impression = ''.obs;
  RxString clicks = ''.obs;
  RxString clickRate = ''.obs;
  RxString favoriteCount = ''.obs;
  RxString totalCost = ''.obs;
  RxString orderRate = ''.obs;
  RxString orderCount = ''.obs;
  List<ImpressionItemModel> impressionItems = [];

  @override
  void onInit() async {
    DateTime now = DateTime.now();
    chosenTagName.value = tags[0];

    var secondDate = DateTime(now.year, now.month - 1, now.day);
    startDateController.text = DateFormat('yyyy-MM-dd').format(now);
    endDateController.text = DateFormat('yyyy-MM-dd').format(secondDate);

    await getImpressionInformation(startDateController.text, endDateController.text, chosenTagName.value);
  }

  Future<void> getImpressionInformation(String startDate, String endDate, String tag) async {
    isLoading.value = true;

    dynamic response = await _apiProvider.getImpressionsInformation(startDate, endDate, tag);
    impressionItems.clear();
    List<ImpressionProductModel> productItems = [];
    _getImpressionData(response);
    var dynamicList = response['product_statistic_list'];
    _getItemData(dynamicList, productItems);

    isLoading.value = false;
  }

  void _getImpressionData(response) {
    impression.value = response['main_statistic_info']['ads_exposure_count'].toString();
    clicks.value = response['main_statistic_info']['ads_click_count'].toString();
    clickRate.value = response['main_statistic_info']['click_rate'].toString();
    favoriteCount.value = response['main_statistic_info']['ads_favorite_count'].toString();
    totalCost.value = response['main_statistic_info']['ads_total_cost'].toString();
    orderRate.value = response['main_statistic_info']['order_rate'].toString();
    orderCount.value = response['main_statistic_info']['ads_order_count'].toString();
  }

  void _getItemData(dynamicList, List<ImpressionProductModel> productItems) {
    for (var i = 0; i < dynamicList.length; i++) {
      var productList = dynamicList[i]['product_detail_statistic_list'];
      for (var j = 0; j < productList.length; j++) {
        productItems.add(
          ImpressionProductModel(
            expressionCount: productList[j]['exposure_count'],
            clickCount: productList[j]['click_count'],
            likeCount: productList[j]['like_count'],
            totalCost: productList[j]['total_cost'],
            clickRate: productList[j]['click_rate'],
            orderRate: productList[j]['order_rate'],
            productInformation: Product(
              category: [productList[j]['product_info']['main_category_name'], productList[j]['product_info']['sub_category_name']],
              price: productList[j]['product_info']['price'],
              title: productList[j]['product_info']['name'],
              id: productList[j]['product_info']['id'],
              imgUrl: productList[j]['product_info']['thumbnail_image_url'],
              store: Store(id: -1),
            ),
          ),
        );
      }
      impressionItems.add(ImpressionItemModel(date: dynamicList[i]['date'], cost: dynamicList[i]['cost_info_text'], products: productItems));
    }
  }

  categoryTagChanged(int index) async {
    chosenTagName.value = tags[index];
    await getImpressionInformation(startDateController.text, endDateController.text, chosenTagName.value);
  }

  dateRangeSubmitted() async {
    await getImpressionInformation(startDateController.text, endDateController.text, chosenTagName.value);
  }
}
