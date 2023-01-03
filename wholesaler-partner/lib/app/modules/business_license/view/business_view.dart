import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/business_license/controller/business_license_controller.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_partner/app/modules/business_license/view/business_edit_view.dart';

class BusinessView extends GetView {
  BusinessView({Key? key}) : super(key: key);
  BusinessLicenseController ctr = Get.put(BusinessLicenseController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BusinessLicenseController());
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: true, title: '사업자등록증 확인'),
      body: _body(),
    );
  }

  Widget _body() {
    return Obx(
      () => ctr.isLoading.value
          ? LoadingWidget()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(),
                  _description(),
                  _licenseNumber(),
                  _image(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      width: Get.width,
                      onPressed: ()=>Get.to(()=>BusinessEditView()),
                      text: 'edit'.tr,
                    ),
                  ),
                  // _imageButton(),
                  SizedBox(
                    height: 50,
                  ),
                  // _editButton()
                ],
              ),
            ),
    );
  }

  Widget _editButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: CustomButton(
        width: Get.width,
        onPressed: () {},
        text: 'edit',
      ),
    );
  }

  // Widget _imageButton() {
  //   return Align(
  //     alignment: Alignment.topRight,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 18.0),
  //       child: Obx(
  //         () => controller.isUploading.value
  //             ? LoadingWidget()
  //             : CustomButton(
  //                 textColor: MyColors.black1,
  //                 borderColor: MyColors.primary,
  //                 backgroundColor: MyColors.white,
  //                 width: Get.width / 3,
  //                 onPressed: () async {
  //                   controller.pickedImage = await controller.pickImage();
  //                   await controller.uploadImage();
  //                 },
  //                 text: 'upload image',
  //               ),
  //       ),
  //     ),
  //   );
  // }

  Widget _image() {
    print('controller.uploadedImageURL = ' + ctr.uploadedImageURL.value.toString());
    return ctr.uploadedImageURL.isEmpty
        ? Center(
            child: Text(
            'no image',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w900, fontSize: 18),
          ))
        : Padding(
            padding: const EdgeInsets.all(18.0),
            child: CachedNetworkImage(
              imageUrl: ctr.uploadedImageURL.value,
              width: Get.width,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                      margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            ),
                      )),

              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
  }

  Widget _licenseNumber() {
    return ctr.number.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '000-00-0000',
              textAlign: TextAlign.start,
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Text(
              ctr.number,
              textAlign: TextAlign.start,
            ),
          );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
      child: Text(
        '사업자 등록 번호',
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _title() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          '사업자등록증',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
