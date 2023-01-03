import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_image_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/orders_inquiry_review_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/order_inquiry_and_review_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/controllers/page5_my_page_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class ReviewDetailController extends GetxController {
  TextEditingController contentController = TextEditingController();

  uApiProvider _apiProvider = uApiProvider();

  Rx<Review>? selectedReviw;
  Rx<String?> reviewImageUrl = ''.obs;
  ProductImageModel? productImageModel;
  RxInt price = (-1).obs;

  bool? isComingFromReviewListPage;

  init(
      {required Review tempSelectedReviw,
      required bool isComingFromOrderInquiryPage}) {
    this.isComingFromReviewListPage = isComingFromOrderInquiryPage;
    // customize for UI
    price.value = tempSelectedReviw.product.price!;
    // selectedReviw = tempSelectedReviw.obs;
    selectedReviw = Review(
      id: tempSelectedReviw.id,
      content: tempSelectedReviw.content,
      rating: tempSelectedReviw.rating,
      ratingType: tempSelectedReviw.ratingType,
      date: tempSelectedReviw.date,
      writer: tempSelectedReviw.writer,
      // writableReviewInfoModel: tempSelectedReviw.writableReviewInfoModel,
      product: Product(
        id: tempSelectedReviw.product.id,
        title: tempSelectedReviw.product.title,
        imgUrl: tempSelectedReviw.product.imgUrl,
        store: tempSelectedReviw.product.store,
        price: tempSelectedReviw.product.price,
        quantity: tempSelectedReviw.product.quantity,
        imgHeight: tempSelectedReviw.product.imgHeight,
        imgWidth: tempSelectedReviw.product.imgWidth,
        OLD_option: tempSelectedReviw.product.OLD_option,
        selectedOptionAddPrice:
            tempSelectedReviw.product.selectedOptionAddPrice,
        orderDetailId: tempSelectedReviw.product.orderDetailId,
      ),
      createdAt: tempSelectedReviw.createdAt,
    ).obs;
    selectedReviw!.value.product.showQuantityPlusMinus = false;
    selectedReviw!.value.product.price = null;
    selectedReviw!.value.product.store.name = null;
    reviewImageUrl = tempSelectedReviw.reviewImageUrl.obs;
  }

  uploadReviewImagePressed() async {
    // hide keyboard
    FocusScope.of(Get.context!).requestFocus(new FocusNode());

    print('uploadReviewImagePressed');
    XFile? _pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    // upload image
    if (_pickedImage != null) {
      productImageModel =
          await _apiProvider.postUploadReviewImage(pickedImage: _pickedImage);

      mSnackbar(message: "이미지가 등록되었습니다.");

      if (productImageModel!.statusCode == 200) {
        print(
            'image uploaded productImageModel.url ${productImageModel!.url}');
        selectedReviw!.value.reviewImageUrl = productImageModel!.url;
        reviewImageUrl.value = productImageModel!.url;
      }
    }
  }

  reviewEditPressed() async {
    print('reviewEditPressed');
    bool isSuccess = await _apiProvider.putReviewEdit(
        content: contentController.text,
        image_path: productImageModel!.path,
        reviewId: selectedReviw!.value.id,
        star: selectedReviw!.value.rating);
    print('edit');
    if (isSuccess) {
      mSnackbar(message: '수정이 완료되었습니다.');
      Get.back();
    }
  }

  reviewAddBtnPressed() async {
    print('reviewAddBtnPressed');
    // check if rating empty
    print('selectedReviw!.value.rating ${selectedReviw!.value.rating}');
    if (selectedReviw!.value.rating == 0) {
      mSnackbar(message: '별점을 선택해주세요.');
      return;
    }

    // check if content empty
    if (contentController.text.isEmpty) {
      mSnackbar(message: '내용을 입력해주세요.');
      return;
    }

    bool isSuccess = await _apiProvider.postReviewAdd(
      orderDetailId: selectedReviw!.value.product.orderDetailId!,
      content: contentController.text,
      image_path:
          productImageModel != null && productImageModel!.statusCode == 200
              ? productImageModel!.path
              : null,
      star: selectedReviw!.value.rating,
    );

    if (isSuccess) {
      Get.delete<OrderInquiryAndReviewController>();
      Get.delete<Page5MyPageController>();

      print(
          'isComingFromReviewListPage $isComingFromReviewListPage go back to review list page');
      Get.to(
          () => OrderInquiryAndReviewView(
              hasHomeButton: true, isBackEnable: false),
          arguments: isComingFromReviewListPage);
    }
  }
}
