import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_3_inquiry_controller.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

Future<dynamic> SubmitInquiryDialog() {
  Tab3InquiryController ctr = Get.put(Tab3InquiryController());
  return showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(MyDimensions.radius))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: Text('Register_product_inquiry'.tr)),
                SizedBox(height: 15),
                TextField(controller: ctr.contentController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: Text('문의내용'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(MyDimensions.radius),
                    ),
                  ),
                  maxLines: 6,
                ),
                SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                            value: ctr.isSecret.value,
                            activeColor: MyColors.primary,
                            onChanged: (value) {
                              ctr.isSecret.toggle();
                            }),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => ctr.isSecret.toggle(),
                        child: Text(
                          '비밀글',
                          style:
                              MyTextStyles.f16.copyWith(color: MyColors.black2),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TwoButtons(
                    rightBtnText: 'submit'.tr,
                    leftBtnText: 'cancel'.tr,
                    rBtnOnPressed: () {
                      ctr.submitInquiryPressed();
                      // Get.back();
                    },
                    lBtnOnPressed: () {
                      Get.back();
                    })
              ],
            ),
          ),
        );
      });
}
