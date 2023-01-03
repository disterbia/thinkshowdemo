import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/models/product_inquiry_model.dart';
import 'package:wholesaler_user/app/models/inquiry_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/models/user_model.dart';
import 'package:wholesaler_user/app/utils/utils.dart';

import '../../../data/api_provider.dart';

class ProductInquiryListController extends GetxController {
  pApiProvider apiProvider = pApiProvider();
  RxBool isLoading = false.obs;
  List<InquiryModel> inquiriesResponse = [];
  List<ProductInquiry> inquiries = [];

  @override
  void onInit() {
    super.onInit();
    getInquiry();
  }

  getInquiry() {
    isLoading.value = true;
    apiProvider.getStoreInquiries().then((response) {
      inquiriesResponse.clear();
      inquiries.clear();

      inquiriesResponse.addAll(response);
      for (var element in inquiriesResponse) {
        print('element.createdAt.toString() ${element.createdAt.toString()}');
        inquiries.add(
          ProductInquiry(
            product: Product(
              id: element.productInfo!.productId!,
              imgHeight: 100,
              imgWidth: 80,
              title: element.productInfo!.name.toString(),
              imgUrl: element.productInfo!.thumbnailImageUrl.toString(),
              store: Store(id: 888888),
            ),
            question: element.content.toString(),
            date: DateFormat("yyyy-MM-dd").parse(element.createdAt.toString()),
            user: User(userID: '', userName: element.writer.toString()),
          ),
        );
      }

      isLoading.value = false;
    });
  }
}
