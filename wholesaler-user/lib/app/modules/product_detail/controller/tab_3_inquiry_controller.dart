import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/inquiry_model.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Tab3InquiryController extends GetxController {
  ProductDetailController productDetailController =
      Get.find<ProductDetailController>();
  uApiProvider _apiProvider = uApiProvider();
  RxBool isSecret = false.obs;
  TextEditingController contentController = TextEditingController();
  RxList<InquiryModel> inquires = <InquiryModel>[].obs;
  int productId = -1;

  Future<void> init() async {
    productId = Get.arguments;
    callInquiryAPI();
  }

  callInquiryAPI() async {
    inquires.value =
        await _apiProvider.getProductInquiries(productId: productId);
  }

  Future<void> submitInquiryPressed() async {
    int productId = productDetailController.productId;
    // print(
    //     'submitInquiryPressed productId $productId content ${contentController.text} isSecret $isSecret');
    if (contentController.text.isEmpty) {
      mSnackbar(message: '문의 사항을 입력해주세요');
      return;
    }

    bool isSuccess = await _apiProvider.postAddInquiry(
        productId: productId,
        content: contentController.text,
        isSecret: isSecret.value);

    if (isSuccess) {
      contentController.clear();
      isSecret.value = false;
      callInquiryAPI();
      Get.back();
    }
  }
}
