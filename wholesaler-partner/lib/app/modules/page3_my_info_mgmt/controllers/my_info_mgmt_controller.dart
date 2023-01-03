import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_partner/app/modules/page3_my_page/controllers/page3_my_page_controller.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/product_image_model.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../../data/api_provider.dart';

class MyInfoMgmtController extends GetxController {
  Page3MyPageController page3MyPageController = Get.put(Page3MyPageController());

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordVerifyController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController verifyPhoneNumberController = TextEditingController();
  int certificationId = -1;
  Store? store;

  final pApiProvider _apiProvider = pApiProvider();
  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;
  XFile? _pickedImage;
  RxString uploadedImageURL = ''.obs;

  RxBool isUploadLoading = false.obs;
  RxString imagePath = ''.obs;

  Future<void> uploadImageBtnPressed() async {
    _pickedImage = await pickImage();
    uploadImage();
  }

  Future<XFile?> pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
  }

  Future<void> uploadImage() async {
    if (_pickedImage != null) {
      isUploadLoading.value = true;
      ProductImageModel? imageModel = await _apiProvider.uploadStoreImage(pickedImage: _pickedImage!);
      if (imageModel != null) {
        imagePath.value = imageModel.path;
      }

      StatusModel statusModel2 = await _apiProvider.uploadStoreThumbnailImage(data: {'image_path': imagePath.value});
      isUploadLoading.value = false;
      if (statusModel2.statusCode == 200) {
        mSnackbar(message: 'image_uploaded'.tr);
        var json = jsonDecode(statusModel2.data.toString());
        uploadedImageURL.value = json['url'];
        page3MyPageController.store.imgUrl!.value = uploadedImageURL.value;
      } else {
        mSnackbar(message: statusModel2.message);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    getUserInfo();
  }

  getUserInfo() {
    isLoading.value = true;
    _apiProvider.getUserInfo().then((response) {
      isLoading.value = false;
      var json = jsonDecode(response.bodyString!);
      bool isOwner = json['is_owner'] ?? false;
      bool isRegistBankInfo = json['is_regist_bank_info'] ?? false;
      String accountId = json['account_id'];
      String storeName = json['store_name'];
      String storeThumbnailImageUrl = json['store_thumbnail_image_url'] ?? '';
      String storeThumbnailImagePath = json['store_thumbnail_image_path'] ?? '';
      int point = json['point'];
      int productTotalCount = json['product_total_count'];
      int storeFavoriteCount = json['store_favorite_count'];
      store = Store(
        id: -1,
        name: storeName,
        imgUrl: storeThumbnailImageUrl.obs,
        totalProducts: productTotalCount,
        totalStoreLiked: storeFavoriteCount,
      );
    }).onError((error, stackTrace) {
      isLoading.value = false;
      mSnackbar(message: error.toString());
    });
  }

  // Future<void> edit() async {
  //   isEditing.value = true;
  //   PhoneNumberPhoneVerifyController ctr = Get.put(PhoneNumberPhoneVerifyController());
  //   certificationId = ctr.certifyId;
  //   if (certificationId == -1) {
  //     mSnackbar(message: '확인 실패');
  //   } else {
  //     await _apiProvider.editUserInformation(
  //         data: {'phone': phoneNumberController.text, 'certifi_id': certificationId, 'password': passwordController.text, 're_password': passwordVerifyController.text}).then((response) {
  //       log('edit. ${response}');
  //       CacheProvider().setToken(response['access_token']);
  //       log('update state product mgmt');
  //       Get.back();
  //       mSnackbar(message: '비밀번호가 변경되었습니다');
  //       Get.back();
  //     });
  //   }
  //   isEditing.value = false;
  // }
}
