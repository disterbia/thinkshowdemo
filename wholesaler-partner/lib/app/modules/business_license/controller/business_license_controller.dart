import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_partner/app/modules/business_license/view/business_view.dart';
import 'package:wholesaler_partner/app/modules/business_registration_submit/controllers/business_registration_submit_controller.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../../data/api_provider.dart';

class BusinessLicenseController extends GetxController {
  final pApiProvider _apiProvider = pApiProvider();
  late TextEditingController BusinessRegisterNumCtr;
  BusinessRegistrationSubmitController businessRegistrationSubmitController =
  Get.put(BusinessRegistrationSubmitController());
  RxBool isLoading = false.obs;
  RxBool isUploading = false.obs;
  // String imagePath = '';
  String number = '';
  XFile? pickedImage;
  RxString uploadedImageURL = ''.obs;

  @override
  void onInit() async {
    BusinessRegisterNumCtr = TextEditingController();
    await getLicenseImage();
  }
  @override
  void dispose() {
    super.dispose();
    BusinessRegisterNumCtr.dispose();
  }

  Future<void> getLicenseImage() async {
    isLoading.value = true;
    var response = await _apiProvider.getBusinessLicense();

    uploadedImageURL.value = response['business_regist_image_url'];
    number = response['business_regist_number'];

    isLoading.value = false;
  }

  Future<XFile?> pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  void validateLicense(){
    if (BusinessRegisterNumCtr.text.isEmpty ) {
      mSnackbar(message: '사업자등록번호를 입력하세요.');
      return;
    }
    if (BusinessRegisterNumCtr.text.length != 10 ) {
      mSnackbar(message: '사업자등록번호 10자리를 입력하세요.');
      return;
    }
    if (Get.find<BusinessRegistrationSubmitController>()
        .uploadedImageURL
        .isEmpty) {
      mSnackbar(message: '사업자등록증 이미지를 업로드하세요.');
      return;
    }
    saveLicense();
  }
  void saveLicense() {

    isLoading.value = true;
    _apiProvider.saveLicense({
      "business_regist_number":
      BusinessRegisterNumCtr.text.isEmpty ? number : BusinessRegisterNumCtr.text,
      "business_regist_image_file_path":businessRegistrationSubmitController.uploadedImagePath.value
    }).then((StatusModel response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
      //  mSnackbar(message: response.message);
        getLicenseImage().then((value) => Get.back());
      } else {
       // mSnackbar(message: response.message);
      }

      isLoading.value = false;
    });
  }

  // Future<void> uploadImage() async {
  //   if (pickedImage != null) {
  //     isUploading.value = true;
  //     _apiProvider
  //         .postUploadBusinessRegisterImage(pickedImage: pickedImage!)
  //         .then((value) {
  //       isUploading.value = false;
  //       mSnackbar(message: 'image_uploaded'.tr);
  //       uploadedImageURL.value = value;
  //     }).onError((error, stackTrace) {
  //       mSnackbar(message: error.toString());
  //       isUploading.value = false;
  //       uploadedImageURL.value = '';
  //     });
  //     log('uploadedImageURL $uploadedImageURL');
  //   }
  // }
}
