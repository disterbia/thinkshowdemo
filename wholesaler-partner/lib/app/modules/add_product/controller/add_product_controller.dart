import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/models/add_product/flexibility_model.dart';
import 'package:wholesaler_partner/app/models/add_product/lining_model.dart';
import 'package:wholesaler_partner/app/models/add_product/option.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/product_body_size_model.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/size_category.dart';
import 'package:wholesaler_partner/app/models/add_product/see_through_model.dart';
import 'package:wholesaler_partner/app/models/add_product/tickness_model.dart';
import 'package:wholesaler_partner/app/models/product_modify_model/product_modify_model.dart';
import 'package:wholesaler_partner/app/models/product_modify_model/size_info_list.dart';
import 'package:wholesaler_partner/app/modules/add_product/part1_category_image_keyword/controller/part1_category_image_keyword_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/part1_clothes_category/view/cloth_category_items_view.dart';
import 'package:wholesaler_partner/app/modules/add_product/part2_image_sizetable_options/controller/part2_image_sizetable_options_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/part3_material_clothwash/controller/part3_material_clothwash_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/part4_modelinfo_htmleditor/controller/part4_modelinfo_htmleditor_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/part5_country/controller/part5_country_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/editor_widget/editor_controller.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/models/cloth_category_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';

class AddProductController extends GetxController {
  pApiProvider _apiProvider = pApiProvider();

  RxList<String> keywordList = <String>[].obs;
  RxList<String> colorsList = <String>[].obs;
  List<Option> options = [];

  List<String> sizesStr = ['FREE, XS, S, M, L'];

  RxBool isEditing = false.obs;
  RxBool isChangeCategoryInEditeMode = false.obs;

  int productIdforEdit = -1;

  List<TextEditingController> optionsControllers = <TextEditingController>[];

  Rx<ClothCategory> category = ClothCategory(icon: '', id: -1, image: '', subCategories: [], title: '').obs;
  Rx<ClothCategoryModel> selectedSubCat = ClothCategoryModel(depth: 0, id: -1, isUse: false, name: '', parentId: -1).obs;
  late TextEditingController productNameController;
  late TextEditingController priceController;

  // Edit Product
  Rx<ProductModifyModel> productModifyModel = ProductModifyModel().obs;

  @override
  void onInit() {
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!init!!!!!!!!!!!!!!!!!!!!!!!!");
    super.onInit();
    productNameController = TextEditingController();
    priceController = TextEditingController();
  }


  toSubCategoryListView(ClothCategory category) {
    Get.to(() => ClothCategoryItemsView(category));
  }

  // EDIT PRODUCT
  getProductEditInfo({required productId}) async {
    AP_Part1Controller part1controller = Get.put(AP_Part1Controller());
    AP_Part2Controller part2controller = Get.put(AP_Part2Controller());
    AP_Part3Controller part3controller = Get.put(AP_Part3Controller());
    AP_Part4Controller part4controller = Get.put(AP_Part4Controller());
    AP_Part5Controller part5controller = Get.put(AP_Part5Controller());
    EditorController editorCtr = Get.put(EditorController());

    productModifyModel.value = await _apiProvider.getProductEditInfo(productId: productId);

    // category and subcaterory
    String catTitle = ClothCategory.getAllItems().firstWhere((clothCat) => clothCat.id == productModifyModel.value.mainCategoryId).name;
    // initialize category
    category.value = ClothCategory(icon: '', id: productModifyModel.value.mainCategoryId!, image: '', subCategories: [], title: catTitle, selectedSubcatIndex: productModifyModel.value.subCategoryId!);
    selectedSubCat.value = ClothCategoryModel(depth: 0, id: productModifyModel.value.subCategoryId!, isUse: true, name: 'selectedSubCat', parentId: productModifyModel.value.mainCategoryId);

    // product name
    productNameController.text = productModifyModel.value.productName!;

    // price
    var f=NumberFormat('###,###,###,###');

    priceController.text = f.format(productModifyModel.value.price).toString();

    // images
    part1controller.imagePath1.value = productModifyModel.value.thumbnailImagePath!;
    part1controller.imageUrl1.value = productModifyModel.value.thumbnailImageUrl!;
    part1controller.imagePath2.value = productModifyModel.value.colorImagePath!;
    part1controller.imageUrl2.value = productModifyModel.value.colorImageUrl!;
    part1controller.imagePath3.value = productModifyModel.value.detailImagePath!;
    part1controller.imageUrl3.value = productModifyModel.value.detailImageUrl!;

    // content
    editorCtr.editorController.setText(productModifyModel.value.content!);

    // country
    part5controller.selectedCountry.value = productModifyModel.value.manufactureCountry!;

    // optionss
    for (Option option in productModifyModel.value.options!) {
      bool listAlreadyContainsColor = colorsList.contains(option.color!);
      colorsList.addIf(!listAlreadyContainsColor, option.color!);
    }

    // materialTypeList
    for (int i = 0; i < productModifyModel.value.materialList!.length; i++) {
      part3controller.materialTypeList.add(productModifyModel.value.materialList![i].name!);
      part3controller.materialTypePercentControllers.add(TextEditingController(text: productModifyModel.value.materialList![i].ratio.toString()));
    }

    // keyword list
    keywordList.clear();
    for (int i = 0; i < productModifyModel.value.keywordList!.length; i++) {
      keywordList.add(productModifyModel.value.keywordList![i].toString());
    }

    // isPrivilage
    part1controller.isDingdongDeliveryActive.value = productModifyModel.value.isPrivilege!;

    // 두께감 ThicknessModel ThicknessType [두꺼움, 얇음, 중간] [thick, thin, middle]
    if (productModifyModel.value.thickness! == 'thick') {
      part3controller.thicknessSelected.value = ThicknessModel(name: '두꺼움', value: ThicknessType.thick);
    } else if (productModifyModel.value.thickness! == 'thin') {
      part3controller.thicknessSelected.value = ThicknessModel(name: '얇음', value: ThicknessType.thin);
    } else if (productModifyModel.value.thickness! == 'middle') {
      part3controller.thicknessSelected.value = ThicknessModel(name: '중간', value: ThicknessType.middle);
    }

    // 비침 SeeThroughModel SeeThroughType [비침, 비침안함] [seeThrough, seeThroughNo]
    if (productModifyModel.value.seeThrough! == 'high') {
      part3controller.seeThroughSelected.value = SeeThroughModel(name: '높음', value: SeeThroughType.high);
    } else if (productModifyModel.value.seeThrough! == 'middle') {
      part3controller.seeThroughSelected.value = SeeThroughModel(name: '중간', value: SeeThroughType.middle);
    } else if (productModifyModel.value.seeThrough! == 'none') {
      part3controller.seeThroughSelected.value = SeeThroughModel(name: '없음', value: SeeThroughType.none);
    }

    // 신축성 FlexibilityModel FlexibilityType [높음, 중간, 없음, 밴딩] [high, middle, none, banding]
    if (productModifyModel.value.flexibility! == 'high') {
      part3controller.flexibilitySelected.value = FlexibilityModel(name: '높음', value: FlexibilityType.high);
    } else if (productModifyModel.value.flexibility! == 'middle') {
      part3controller.flexibilitySelected.value = FlexibilityModel(name: '중간', value: FlexibilityType.middle);
    } else if (productModifyModel.value.flexibility! == 'none') {
      part3controller.flexibilitySelected.value = FlexibilityModel(name: '없음', value: FlexibilityType.none);
    } else if (productModifyModel.value.flexibility! == 'banding') {
      part3controller.flexibilitySelected.value = FlexibilityModel(name: '밴딩', value: FlexibilityType.banding);
    }

    // 안감 LiningModel LiningType isLining [true, false]
    if (productModifyModel.value.isLining! == true) {
      part3controller.liningsSelected.value = LiningModel(name: 'included', title: '있음');
    } else {
      part3controller.liningsSelected.value = LiningModel(name: 'not_included', title: '없음');
    }

    // clothWashToggle
    // handWash handWash
    if (productModifyModel.value.isHandWash! == true) {
      part3controller.clothWashToggles.firstWhere((clothwash) => clothwash.id == ClothCareGuideId.handWash).isActive.value = true;
    }
    // isDryCleaning dryCleaning
    if (productModifyModel.value.isDryCleaning! == true) {
      part3controller.clothWashToggles.firstWhere((clothwash) => clothwash.id == ClothCareGuideId.dryCleaning).isActive.value = true;
    }
    // isWaterWash waterWash
    if (productModifyModel.value.isWaterWash! == true) {
      part3controller.clothWashToggles.firstWhere((clothwash) => clothwash.id == ClothCareGuideId.waterWash).isActive.value = true;
    }
    // isSingleWash separateWash
    if (productModifyModel.value.isSingleWash! == true) {
      part3controller.clothWashToggles.firstWhere((clothwash) => clothwash.id == ClothCareGuideId.separateWash).isActive.value = true;
    }
    // ClothCareGuideId.woolWash
    if (productModifyModel.value.isWoolWash! == true) {
      part3controller.clothWashToggles.firstWhere((clothwash) => clothwash.id == ClothCareGuideId.woolWash).isActive.value = true;
    }

    // isNotBleash noBleach
    if (productModifyModel.value.isNotBleash! == true) {
      part3controller.clothWashToggles.firstWhere((bleach) => bleach.id == ClothCareGuideId.noBleach).isActive.value = true;
    }

    // isNotIroning noIron
    if (productModifyModel.value.isNotIroning! == true) {
      part3controller.clothWashToggles.firstWhere((iron) => iron.id == ClothCareGuideId.noIron).isActive.value = true;
    }

    // isNotMachineWash noLaundryMachine
    if (productModifyModel.value.isNotMachineWash! == true) {
      part3controller.clothWashToggles.firstWhere((laundryMachine) => laundryMachine.id == ClothCareGuideId.noLaundryMachine).isActive.value = true;
    }

    // model info > modelHeightController
    part4controller.modelHeightController.text = productModifyModel.value.modelInfo!.height ?? '';
    // modelWeightController
    part4controller.modelWeightController.text = productModifyModel.value.modelInfo!.modelWeight ?? '';
    // modelSizeController
    part4controller.modelSizeController.text = productModifyModel.value.modelInfo!.modelSize ?? '';

    // productBodySizeList
    // List<String> sizes = ['FREE', 'XS', 'S', 'M', 'L'];
    part2controller.createProductBodySizeList(null);
  }
}
