import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/add_product/see_through_model.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/cloth_wash_toggle/cloth_wash_model.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';

import '../../../../constant/enums.dart';
import '../../../../models/add_product/flexibility_model.dart';
import '../../../../models/add_product/lining_model.dart';
import '../../../../models/add_product/tickness_model.dart';

class AP_Part3Controller extends GetxController {
  TextEditingController materialTypeController = TextEditingController();
  List<TextEditingController> materialTypePercentControllers = [];

  // Material Variables
  RxList<String> materialTypeList = <String>[].obs;

  Rx<ThicknessModel> thicknessSelected = ThicknessModel(name: 'thick'.tr, value: ThicknessType.thick).obs;
  List<ThicknessModel> thickNessList = [
    ThicknessModel(name: 'thick'.tr, value: ThicknessType.thick),
    ThicknessModel(name: 'middle'.tr, value: ThicknessType.middle),
    ThicknessModel(name: 'thin'.tr, value: ThicknessType.thin)
  ];

  Rx<SeeThroughModel> seeThroughSelected = SeeThroughModel(name: 'height'.tr, value: SeeThroughType.high).obs;
  List<SeeThroughModel> seeThroughList = [
    SeeThroughModel(name: 'height'.tr, value: SeeThroughType.high),
    SeeThroughModel(name: 'middle'.tr, value: SeeThroughType.middle),
    SeeThroughModel(name: 'not_included'.tr, value: SeeThroughType.none)
  ];

  Rx<FlexibilityModel> flexibilitySelected = FlexibilityModel(name: 'height'.tr, value: FlexibilityType.high).obs;
  List<FlexibilityModel> flexibilityList = [
    FlexibilityModel(name: 'height'.tr, value: FlexibilityType.high),
    FlexibilityModel(name: 'middle'.tr, value: FlexibilityType.middle),
    FlexibilityModel(name: 'not_included'.tr, value: FlexibilityType.none),
    FlexibilityModel(name: 'banding'.tr, value: FlexibilityType.none)
  ];

  Rx<LiningModel> liningsSelected = LiningModel(title: 'included'.tr, name: 'included').obs;
  List<LiningModel> liningList = [
    LiningModel(title: 'included'.tr, name: 'included'),
    LiningModel(title: 'not_included'.tr, name: 'not_included'),
  ];

  RxList<ClothWash> clothWashToggles = [
    ClothWash(iconPath: 'assets/shared_images_icons/ic_cloth_wash_1_hand_wash.png', title: '손세탁', isActive: false.obs, id: ClothCareGuideId.handWash),
    ClothWash(iconPath: 'assets/shared_images_icons/ic_cloth_wash_2_dry_cleaning.png', title: '드라이클리닝', isActive: false.obs, id: ClothCareGuideId.dryCleaning),
    ClothWash(iconPath: 'assets/shared_images_icons/ic_cloth_wash_3_water_wash.png', title: '물세탁', isActive: false.obs, id: ClothCareGuideId.waterWash),
    ClothWash(iconPath: 'assets/shared_images_icons/ic_cloth_wash_4_separate_wash.png', title: '단독세탁', isActive: false.obs, id: ClothCareGuideId.separateWash),
    ClothWash(iconPath: 'assets/shared_images_icons/ic_cloth_wash_5_wool_wash.png', title: '울세탁', isActive: false.obs, id: ClothCareGuideId.woolWash),
    ClothWash(iconPath: 'assets/shared_images_icons/ic_cloth_wash_6_no_bleach.png', title: '표백제 사용 금지', isActive: false.obs, id: ClothCareGuideId.noBleach),
    ClothWash(iconPath: 'assets/shared_images_icons/ic_cloth_wash_7_no_iron.png', title: '다림질 금지', isActive: false.obs, id: ClothCareGuideId.noIron),
    ClothWash(iconPath: 'assets/shared_images_icons/ic_cloth_wash_8_no_laundry_machine.png', title: '세탁기 금지', isActive: false.obs, id: ClothCareGuideId.noLaundryMachine),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    thicknessSelected.value = thickNessList[0];
    seeThroughSelected.value = seeThroughList[0];
    flexibilitySelected.value = flexibilityList[0];
    liningsSelected.value = liningList[0];
  }
}
