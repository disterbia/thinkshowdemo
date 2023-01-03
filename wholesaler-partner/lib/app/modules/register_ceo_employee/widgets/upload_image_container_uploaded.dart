import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/business_registration_submit/controllers/business_registration_submit_controller.dart';
import 'package:wholesaler_partner/app/modules/business_registration_submit/views/business_registration_submit_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

/// 업로드 했던 이미지
class UploadImageContainer_uploaded extends StatelessWidget {
  BusinessRegistrationSubmitController businessRegistrationSubmitController =
      Get.put(BusinessRegistrationSubmitController());
  UploadImageContainer_uploaded();

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      dashPattern: [5, 5],
      strokeWidth: 1,
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Expanded(
                  child: Image.network(businessRegistrationSubmitController
                      .uploadedImageURL.value)),
              IconButton(
                  onPressed: () {
                    businessRegistrationSubmitController
                        .uploadedImageURL.value = '';
                    mSnackbar(message: 'business_register_image_deleted'.tr);
                  },
                  icon: Icon(Icons.delete_outline_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
