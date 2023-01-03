import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/add_product/part3_material_clothwash/controller/part3_material_clothwash_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/add_tag.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/cloth_wash_toggle/cloth_wash_toggle.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/custom_input.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';

import '../../../../models/add_product/flexibility_model.dart';
import '../../../../models/add_product/lining_model.dart';
import '../../../../models/add_product/see_through_model.dart';
import '../../../../models/add_product/tickness_model.dart';

class AP_Part3View extends GetView<AP_Part3Controller> {
  AP_Part3Controller ctr = Get.put(AP_Part3Controller());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _materialField(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('혼용률 입력'),
          ),
          for (var i = 0; i < ctr.materialTypeList.length; i++) _materialPercent(i),
          SizedBox(
            height: 10,
          ),
          _thickness(ctr.thickNessList, 'thickness'.tr),
          _seeThrough(ctr.seeThroughList, 'see_through'.tr, ctr.seeThroughSelected),
          _flexibility(ctr.flexibilityList, 'elasticity'.tr, ctr.flexibilitySelected),
          _lining(ctr.liningList, 'lining'.tr, ctr.liningsSelected),
          Text('Garment_Care_Guide'.tr),
          clothWashTipsGrid()
        ],
      );
    });
  }

  Widget _materialField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
      child: AddTagField(
        hintText: 'Material_selection'.tr,
        tagList: ctr.materialTypeList,
        fieldController: ctr.materialTypeController,
        percentList: ctr.materialTypePercentControllers,
        onAddTag: () {
          ctr.materialTypePercentControllers.add(TextEditingController());
        },
        onDeleteTag: (i) {
          ctr.materialTypePercentControllers.removeAt(i);
        },
      ),
    );
  }

  Widget _materialPercent(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CustomInput(keyboardType: TextInputType.number,
        label: ctr.materialTypeList[i],
        fieldController: ctr.materialTypePercentControllers[i],
        prefix: '%',
      ),
    );
  }

  Widget _thickness(List<ThicknessModel> buttons, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Row(
            children: [
              for (ThicknessModel button in buttons)
                Expanded(
                  // set padding for all buttons except last button. in other words, set padding in the middle of buttons only.
                  child: Padding(
                    padding: EdgeInsets.only(right: buttons.length == buttons.indexOf(button) + 1 ? 0 : 10),
                    child: CustomButton(
                      textColor: ctr.thicknessSelected.value.name == button.name ? MyColors.white : MyColors.grey2,
                      fontSize: 14,
                      borderColor: ctr.thicknessSelected.value.name == button.name ? MyColors.primary : MyColors.grey1,
                      backgroundColor: ctr.thicknessSelected.value.name == button.name ? MyColors.primary : MyColors.white,
                      onPressed: () {
                        ctr.thicknessSelected.value = button;
                      },
                      text: button.name,
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  Widget _seeThrough(List<SeeThroughModel> buttons, String title, Rx<SeeThroughModel> clothesSample) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Row(
              children: [
                for (SeeThroughModel button in buttons)
                  Expanded(
                    // set padding for all buttons except last button. in other words, set padding in the middle of buttons only.
                    child: Padding(
                      padding: EdgeInsets.only(right: buttons.length == buttons.indexOf(button) + 1 ? 0 : 10),
                      child: CustomButton(
                        textColor: clothesSample.value.name == button.name ? MyColors.white : MyColors.grey2,
                        fontSize: 14,
                        borderColor: clothesSample.value.name == button.name ? MyColors.primary : MyColors.grey1,
                        backgroundColor: clothesSample.value.name == button.name ? MyColors.primary : MyColors.white,
                        onPressed: () {
                          clothesSample.value = button;
                        },
                        text: button.name,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _flexibility(List<FlexibilityModel> buttons, String title, Rx<FlexibilityModel> clothesSample) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Row(
              children: [
                for (FlexibilityModel button in buttons)
                  Expanded(
                    // set padding for all buttons except last button. in other words, set padding in the middle of buttons only.
                    child: Padding(
                      padding: EdgeInsets.only(right: buttons.length == buttons.indexOf(button) + 1 ? 0 : 10),
                      child: CustomButton(
                        textColor: clothesSample.value.name == button.name ? MyColors.white : MyColors.grey2,
                        fontSize: 14,
                        borderColor: clothesSample.value.name == button.name ? MyColors.primary : MyColors.grey1,
                        backgroundColor: clothesSample.value.name == button.name ? MyColors.primary : MyColors.white,
                        onPressed: () {
                          clothesSample.value = button;
                        },
                        text: button.name,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _lining(List<LiningModel> buttons, String title, Rx<LiningModel> clothesSample) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Row(
              children: [
                for (LiningModel button in buttons)
                  Expanded(
                    // set padding for all buttons except last button. in other words, set padding in the middle of buttons only.
                    child: Padding(
                      padding: EdgeInsets.only(right: buttons.length == buttons.indexOf(button) + 1 ? 0 : 10),
                      child: CustomButton(
                        textColor: clothesSample.value.name == button.name ? MyColors.white : MyColors.grey2,
                        fontSize: 14,
                        borderColor: clothesSample.value.name == button.name ? MyColors.primary : MyColors.grey1,
                        backgroundColor: clothesSample.value.name == button.name ? MyColors.primary : MyColors.white,
                        onPressed: () {
                          clothesSample.value = button;
                        },
                        text: button.title,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget clothWashTipsGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          children: List.generate(8, (index) {
            return ClothWashToggle(
              clothWash: ctr.clothWashToggles[index],
              onPressed: () {
                ctr.clothWashToggles[index].isActive.toggle();
              },
            );
          }),
        ),
      ),
    );
  }
}
