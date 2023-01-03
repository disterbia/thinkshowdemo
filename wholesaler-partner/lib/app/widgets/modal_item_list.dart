import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

class ModelItemList {
  ModelItemList() {
    showCupertinoModalBottomSheet(
      context: Get.context!,
      builder: (context) => SafeArea(
        child: Container(
          height: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Text(
                  '최신수',
                  style: MyTextStyles.f16,
                ),
                label: const Icon(
                  Icons.check,
                  color: MyColors.black,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Text(
                  'by_sales'.tr,
                  style: MyTextStyles.f16,
                ),
                label: const Icon(
                  Icons.check,
                  color: MyColors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
