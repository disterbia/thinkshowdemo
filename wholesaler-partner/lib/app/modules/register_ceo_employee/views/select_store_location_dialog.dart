import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/models/register_ceo_employee/address.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_2_controller.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

SelectStoreLocationDialog() async {
  RegisterCeoEmployee2Controller registerP2Ctr =
      Get.put(RegisterCeoEmployee2Controller());

  if (registerP2Ctr.storeLocations.length == 0) {
    mSnackbar(message: '상호명이 존재하지 않습니다.');
    return;
  } else {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          height: Get.height - 200,
          child: Obx(() => ListView.builder(
              itemCount: registerP2Ctr.storeLocations.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    registerP2Ctr.storeLocationSelectPressed(index);
                    Get.back();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        registerP2Ctr.storeLocations[index].business_name!,
                        style: MyTextStyles.f16_bold
                            .copyWith(color: MyColors.black1),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(registerP2Ctr
                                  .storeLocations[index].buildingInfo!.name! +
                              ' , ' +
                              registerP2Ctr
                                  .storeLocations[index].floorInfo!.name! +
                              ' , ' +
                              registerP2Ctr
                                  .storeLocations[index].unitInfo!.name!)
                        ],
                      ),
                      SizedBox(height: 15),
                      Divider(),
                    ],
                  ),
                );
              })),
        ),
      ),
    );
  }
}
