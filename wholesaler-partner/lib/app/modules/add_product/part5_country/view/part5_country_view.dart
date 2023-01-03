import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/add_product/part5_country/controller/part5_country_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/custom_input.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/input.dart';

import '../../../../models/add_product/country_model.dart';

class AP_Part5View extends GetView<AP_Part5Controller> {
  AP_Part5Controller ctr = Get.put(AP_Part5Controller());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Country_manufacture_required'.tr,
            style: MyTextStyles.f16.copyWith(color: MyColors.black2),
          ),
          SizedBox(height: 20),
          GestureDetector(
            child: Row(
              children: [
                Obx(() => Text(ctr.selectedCountry.value)),
                Icon(Icons.keyboard_arrow_down_sharp),
              ],
            ),
            onTap: () {
              showSelectCountryDialog();
            },
          ),
          Obx(() {
            return (ctr.selectedCountry.value == '직접입력')
                ? Column(
                    children: [
                      SizedBox(height: 12),
                      InputWidget(
                        labelText: 'Direct_input'.tr,
                        controller: ctr.directController,
                      ),
                    ],
                  )
                : SizedBox();
          }),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  void showSelectCountryDialog() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        context: Get.context!,
        builder: (context) {
          return Obx(
            () => SafeArea(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [for (String country in ctr.countries) _countryListItem(country)],
                ),
              ),
            ),
          );
        });
  }

  Widget _countryListItem(String country) {
    return InkWell(
      onTap: () {
        ctr.selectedCountry.value = country;
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(country),
              if (country == ctr.selectedCountry.value)
                Icon(
                  Icons.check,
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
