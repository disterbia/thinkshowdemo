import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/add_product/part4_modelinfo_htmleditor/controller/part4_modelinfo_htmleditor_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/custom_input.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/editor_widget/editor_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

/// 모델정보
class AP_Part4View extends GetView<AP_Part4Controller> {
  AP_Part4Controller ctr = Get.put(AP_Part4Controller());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            '모델정보',
            style: MyTextStyles.f16.copyWith(color: MyColors.black2),
          ),
          SizedBox(height: 14),
          CustomInput(
            label: '키',
            fieldController: ctr.modelHeightController,
            prefix: 'CM',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 5),
          CustomInput(
            keyboardType: TextInputType.number,
            label: '몸무게',
            fieldController: ctr.modelWeightController,
            prefix: 'KG',
          ),
          SizedBox(height: 5),
          CustomInput(
            label: '사이즈',
            fieldController: ctr.modelSizeController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 30),
          EditorWidget(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
