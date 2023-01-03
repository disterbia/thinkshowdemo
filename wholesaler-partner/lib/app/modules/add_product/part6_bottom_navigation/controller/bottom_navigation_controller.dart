import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/product_body_size_model.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/size_child.dart';
import 'package:wholesaler_partner/app/models/material_model.dart';
import 'package:wholesaler_partner/app/modules/add_product/part4_modelinfo_htmleditor/controller/part4_modelinfo_htmleditor_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/editor_widget/editor_controller.dart';
import 'package:wholesaler_partner/app/modules/dingdong_delivery/controllers/dingdong_delivery_controller.dart';
import 'package:wholesaler_partner/app/modules/page1_home/controller/partner_home_controller.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/controller/product_mgmt_controller.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/view/product_mgmt_view.dart';
import 'package:wholesaler_partner/app/widgets/bottom_navbar/bottom_navbar_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../../../data/api_provider.dart';
import '../../controller/add_product_controller.dart';
import '../../part1_category_image_keyword/controller/part1_category_image_keyword_controller.dart';
import '../../part2_image_sizetable_options/controller/part2_image_sizetable_options_controller.dart';
import '../../part3_material_clothwash/controller/part3_material_clothwash_controller.dart';
import '../../part5_country/controller/part5_country_controller.dart';

class AP_Part6Controller extends GetxController {
  final pApiProvider _apiProvider = pApiProvider();

  ProductMgmtController c = Get.put(ProductMgmtController());
  RxBool isLoading = false.obs;

  Future<void> addProduct() async {
    AddProductController addProductController = Get.find<AddProductController>();
    AP_Part1Controller part1controller = Get.find<AP_Part1Controller>();
    AP_Part2Controller part2controller = Get.find<AP_Part2Controller>();
    AP_Part3Controller part3controller = Get.find<AP_Part3Controller>();
    AP_Part4Controller part4controller = Get.find<AP_Part4Controller>();
    AP_Part5Controller part5controller = Get.find<AP_Part5Controller>();
    EditorController editorCtr = Get.find<EditorController>();
    int mainCategoryId = (addProductController.selectedSubCat != null)
        ? addProductController.selectedSubCat.value.parentId!
        : 0;
    int subCategoryId = (addProductController.selectedSubCat.value.id != -1)
        ? addProductController.selectedSubCat.value.id
        : 0;
    String productName = addProductController.productNameController.text;
    String price = addProductController.priceController.text.replaceAll(RegExp(r'[^0-9]'),'');
    String imagePath1 = part1controller.imagePath1.value;
    String imagePath2 = part1controller.imagePath2.value;
    String imagePath3 = part1controller.imagePath3.value;

    String content = await editorCtr.editorController.getText();

    String country = part5controller.selectedCountry.value == '직접입력'
        ? part5controller.directController.text
        : part5controller.selectedCountry.value;

    // option
    print('optionsControllers.length ${addProductController.optionsControllers.length}');
    for (int i = 0; i < addProductController.optionsControllers.length; i++) {
      String addPrice = addProductController.optionsControllers[i].text;
      if (addPrice.isEmpty) {
        Get.back();
        mSnackbar(message: '옵션 추가 금액을 입력해주세요.');
        return;
      }
      addProductController.options[i].addPrice = addPrice;
    }

    if (part2controller.isOptionCheckbox.value) {
      // for (int i = 0; i < addProductController.options.length; i++) {
      for (int i = 0; i < addProductController.optionsControllers.length; i++) {
        String addPrice = addProductController.optionsControllers[i].text;
        if (addPrice.isEmpty) {
          Get.back();
          mSnackbar(message: '옵션 추가 금액을 입력해주세요.');
          return;
        }
        addProductController.options[i].addPrice = addPrice;
      }
    } else {
      for (int i = 0; i < addProductController.options.length; i++) {
        addProductController.options[i].addPrice = "0";
      }
    }

    List<MaterialModel> materialList = [];
    materialList.clear();
    for (int i = 0; i < part3controller.materialTypeList.length; i++) {
      materialList.add(MaterialModel(
          name: part3controller.materialTypeList[i],
          percent: part3controller.materialTypePercentControllers[i].text));
    }

    for (int i = 0; i < part3controller.materialTypeList.length; i++) {
      if(part3controller.materialTypePercentControllers[i].text.isEmpty) return mSnackbar(message: "혼용률 입력하세요.");
    }

    if (mainCategoryId == 0) {
      Get.back();
      mSnackbar(message: '카테고리가 설정되지 않았습니다.');
      return;
    }

    if(addProductController.colorsList.isEmpty){
      Get.back();
      mSnackbar(message: '색상을 추가해주세요.');
      return;
    }

    if (productName.isEmpty) {
      Get.back();
      mSnackbar(message: '상품명을 입력해주세요.');
      return;
    }

    if (imagePath1.isEmpty) {
      Get.back();
      mSnackbar(message: '대표 이미지를 선택해주세요.');
      return;
    }

    if (imagePath2.isEmpty) {
      Get.back();
      mSnackbar(message: '색상별 이미지를 선택해주세요.');
      return;
    }

    if (imagePath3.isEmpty) {
      Get.back();
      mSnackbar(message: '디테일 컷 이미지를 선택해주세요.');
      return;
    }

    if (price.isEmpty) {
      Get.back();
      mSnackbar(message: '상품 가격을 입력해주세요.');
      return;
    }

    if (country.isEmpty) {
      Get.back();
      mSnackbar(message: '제조국가를 선택해주세요.');
      return;
    }

    if (content.isEmpty) {
      Get.back();
      mSnackbar(message: '본문 항목을 적어주세요.');
      return;
    }

    isLoading.value = true;

    // size_info_list
    List<Map<String, dynamic>> sizeInfoList = [];
    for (int i = 0; i < part2controller.productBodySizeList.length; i++) {
      ProductBodySizeModel productBodySizeModel =
          part2controller.productBodySizeList[i];
      if (productBodySizeModel.isSelected.value) {
        Map<String, dynamic> sizeInfo = {"size": productBodySizeModel.size};
        for (int j = 0;
            j < productBodySizeModel.sizeCategory.children.length;
            j++) {
          SizeChild sizeChild = productBodySizeModel.sizeCategory.children[j];
          sizeInfo[sizeChild.english] = part2controller
              .textEditingControllers[i.toString() + j.toString()]!.text;
        }

        sizeInfoList.add(sizeInfo);
      }
    }

    if (sizeInfoList.isEmpty) {
      isLoading.value=false;
      Get.back();
      mSnackbar(message: '사이즈 선택해주세요.');
      return;
    }
    Map<String, dynamic> data = {
      "product_name": productName,
      "main_category_id": mainCategoryId,
      "sub_category_id": subCategoryId,
      "thumbnail_image_path": imagePath1,
      "color_image_path": imagePath2,
      "detail_image_path": imagePath3,
      "is_privilege": part1controller.isDingdongDeliveryActive.value,
      "price": price,
      "keyword_list": addProductController.keywordList.toList(),
      "material_list": json.decode(materialList.toString()),
      "thickness": part3controller.thicknessSelected.value.toString(),
      "see_through": part3controller.seeThroughSelected.value.toString(),
      "flexibility": part3controller.flexibilitySelected.value.toString(),
      "is_lining":
          part3controller.liningsSelected.value.toString() == 'included',
      "content": content,
      "manufacture_country": country,
      "is_hand_wash": part3controller.clothWashToggles[0].isActive.value,
      "is_dry_cleaning": part3controller.clothWashToggles[1].isActive.value,
      "is_water_wash": part3controller.clothWashToggles[2].isActive.value,
      "is_single_wash": part3controller.clothWashToggles[3].isActive.value,
      "is_wool_wash": part3controller.clothWashToggles[4].isActive.value,
      "is_not_bleash": part3controller.clothWashToggles[5].isActive.value,
      "is_not_ironing": part3controller.clothWashToggles[6].isActive.value,
      "is_not_machine_wash": part3controller.clothWashToggles[7].isActive.value,
      "option_list": json.decode(addProductController.options.toString()),
      "size_info_list": sizeInfoList,
      "model_height": part4controller.modelHeightController.text,
      "model_weight": part4controller.modelWeightController.text != ''
          ? int.parse(part4controller.modelWeightController.text)
          : '',
      "model_size": part4controller.modelSizeController.text,
    };

    bool isSuccess = false;
      isSuccess = await _apiProvider.addProduct(data: data);


    if (isSuccess) {
      mSnackbar(message: '제품이 정상적으로 추가되었습니다.');
      editorCtr.editorController.clearFocus();
      Get.delete<PartnerHomeController>();
      Get.delete<DingdongDeliveryController>();
      Get.delete<EditorController>();
      Get.delete<AddProductController>();
      Get.delete<AP_Part1Controller>();
      Get.delete<AP_Part2Controller>();
      Get.delete<AP_Part3Controller>();
      Get.delete<AP_Part4Controller>();
      Get.delete<AP_Part5Controller>();
      Get.delete<BottomNavbarController>();
      Get.delete<ProductMgmtController>();
      c.getProducts(isScrolling: false);

      Get.to(ProductMgmtView());


    }
    isLoading.value = false;
  }
  void fuckingTest(){
    AddProductController addProductController = Get.find<AddProductController>();
    String productName = addProductController.productNameController.text;
    print("productName22222222====@======${addProductController.productIdforEdit}");
    print("productName====@======$productName");
    print("productName3333====@======${addProductController.productIdforEdit}");
  }
  Future<void> editProduct() async {
    AddProductController addProductController = Get.find<AddProductController>();
    AP_Part1Controller part1controller = Get.find<AP_Part1Controller>();
    AP_Part2Controller part2controller = Get.find<AP_Part2Controller>();
    AP_Part3Controller part3controller = Get.find<AP_Part3Controller>();
    AP_Part4Controller part4controller = Get.find<AP_Part4Controller>();
    AP_Part5Controller part5controller = Get.find<AP_Part5Controller>();
    EditorController editorCtr = Get.find<EditorController>();

    print("productName22222222==========${addProductController.productIdforEdit}");
    int mainCategoryId = (addProductController.selectedSubCat != null)
        ? addProductController.selectedSubCat.value.parentId!
        : 0;
    int subCategoryId = (addProductController.selectedSubCat.value.id != -1)
        ? addProductController.selectedSubCat.value.id
        : 0;
    String productName = addProductController.productNameController.text;
    print("productName==========$productName");
    print("productName3333==========${addProductController.productIdforEdit}");
    String price = addProductController.priceController.text.replaceAll(RegExp(r'[^0-9]'),'');
    String imagePath1 = part1controller.imagePath1.value;
    String imagePath2 = part1controller.imagePath2.value;
    String imagePath3 = part1controller.imagePath3.value;

    String content = await editorCtr.editorController.getText();

    String country = part5controller.selectedCountry.value == '직접입력'
        ? part5controller.directController.text
        : part5controller.selectedCountry.value;

    // option
    print('optionsControllers.length ${addProductController.optionsControllers.length}');
    for (int i = 0; i < addProductController.optionsControllers.length; i++) {
      String addPrice = addProductController.optionsControllers[i].text;
      if (addPrice.isEmpty) {
        Get.back();
        mSnackbar(message: '옵션 추가 금액을 입력해주세요.');
        return;
      }
      addProductController.options[i].addPrice = addPrice;
    }

    if (part2controller.isOptionCheckbox.value) {
      // for (int i = 0; i < addProductController.options.length; i++) {
      for (int i = 0; i < addProductController.optionsControllers.length; i++) {
        String addPrice = addProductController.optionsControllers[i].text;
        if (addPrice.isEmpty) {
          Get.back();
          mSnackbar(message: '옵션 추가 금액을 입력해주세요.');
          return;
        }
        addProductController.options[i].addPrice = addPrice;
      }
    } else {
      for (int i = 0; i < addProductController.options.length; i++) {
        addProductController.options[i].addPrice = "0";
      }
    }

    List<MaterialModel> materialList = [];
    materialList.clear();
    for (int i = 0; i < part3controller.materialTypeList.length; i++) {
      part3controller.materialTypePercentControllers.add(TextEditingController());
      materialList.add(MaterialModel(
          name: part3controller.materialTypeList[i],
          percent: part3controller.materialTypePercentControllers[i].text));
    }
    bool temp = false;
    for (int i = 0; i < part3controller.materialTypeList.length; i++) {
      if (part3controller.materialTypePercentControllers[i].text.isEmpty){
        temp = true;
      }
    }

    if(temp){
      Get.back();
      mSnackbar(message: '혼용률 입력하세요.');
      return;
    }

    if(addProductController.colorsList.isEmpty){
      Get.back();
      mSnackbar(message: '색상을 추가해주세요.');
      return;
    }

    if (mainCategoryId == 0) {
      Get.back();
      mSnackbar(message: '카테고리가 설정되지 않았습니다.');
      return;
    }

    if (productName.isEmpty) {
      Get.back();
      mSnackbar(message: '상품명을 입력해주세요.');
      return;
    }

    if (imagePath1.isEmpty) {
      Get.back();
      mSnackbar(message: '대표 이미지를 선택해주세요.');
      return;
    }

    if (imagePath2.isEmpty) {
      Get.back();
      mSnackbar(message: '색상별 이미지를 선택해주세요.');
      return;
    }

    if (imagePath3.isEmpty) {
      Get.back();
      mSnackbar(message: '디테일 컷 이미지를 선택해주세요.');
      return;
    }

    if (price.isEmpty) {
      Get.back();
      mSnackbar(message: '상품 가격을 입력해주세요.');
      return;
    }

    if (country.isEmpty) {
      Get.back();
      mSnackbar(message: '제조국가를 선택해주세요.');
      return;
    }

    if (content.isEmpty) {
      Get.back();
      mSnackbar(message: '본문 항목을 적어주세요.');
      return;
    }

    isLoading.value = true;

    // size_info_list
    List<Map<String, dynamic>> sizeInfoList = [];
    for (int i = 0; i < part2controller.productBodySizeList.length; i++) {
      ProductBodySizeModel productBodySizeModel =
      part2controller.productBodySizeList[i];
      if (productBodySizeModel.isSelected.value) {
        Map<String, dynamic> sizeInfo = {"size": productBodySizeModel.size};
        for (int j = 0;
        j < productBodySizeModel.sizeCategory.children.length;
        j++) {
          SizeChild sizeChild = productBodySizeModel.sizeCategory.children[j];
          sizeInfo[sizeChild.english] = part2controller
              .textEditingControllers[i.toString() + j.toString()]!.text;
        }

        sizeInfoList.add(sizeInfo);
      }
    }

    if (sizeInfoList.isEmpty) {
      Get.back();
      mSnackbar(message: '사이즈 선택해주세요.');
      return;
    }
    Map<String, dynamic> data = {
      "product_name": productName,
      "main_category_id": mainCategoryId,
      "sub_category_id": subCategoryId,
      "thumbnail_image_path": imagePath1,
      "color_image_path": imagePath2,
      "detail_image_path": imagePath3,
      "is_privilege": part1controller.isDingdongDeliveryActive.value,
      "price": price,
      "keyword_list": addProductController.keywordList.toList(),
      "material_list": json.decode(materialList.toString()),
      "thickness": part3controller.thicknessSelected.value.toString(),
      "see_through": part3controller.seeThroughSelected.value.toString(),
      "flexibility": part3controller.flexibilitySelected.value.toString(),
      "is_lining":
      part3controller.liningsSelected.value.toString() == 'included',
      "content": content,
      "manufacture_country": country,
      "is_hand_wash": part3controller.clothWashToggles[0].isActive.value,
      "is_dry_cleaning": part3controller.clothWashToggles[1].isActive.value,
      "is_water_wash": part3controller.clothWashToggles[2].isActive.value,
      "is_single_wash": part3controller.clothWashToggles[3].isActive.value,
      "is_wool_wash": part3controller.clothWashToggles[4].isActive.value,
      "is_not_bleash": part3controller.clothWashToggles[5].isActive.value,
      "is_not_ironing": part3controller.clothWashToggles[6].isActive.value,
      "is_not_machine_wash": part3controller.clothWashToggles[7].isActive.value,
      "option_list": json.decode(addProductController.options.toString()),
      "size_info_list": sizeInfoList,
      "model_height": part4controller.modelHeightController.text,
      "model_weight": part4controller.modelWeightController.text != ''
          ? int.parse(part4controller.modelWeightController.text)
          : '',
      "model_size": part4controller.modelSizeController.text,
    };
    print(json.decode(addProductController.options.toString()),);
    bool isSuccess = false;
      isSuccess = await _apiProvider.editProduct(
          productId: addProductController.productIdforEdit, data: data);

    if (isSuccess) {
      editorCtr.editorController.clearFocus();
      mSnackbar(message: '제품이 정상적으로 추가되었습니다.');
      editorCtr.editorController.clearFocus();
      Get.delete<PartnerHomeController>();
      Get.delete<DingdongDeliveryController>();
      Get.delete<EditorController>();
      Get.delete<AddProductController>();
      Get.delete<AP_Part1Controller>();
      Get.delete<AP_Part2Controller>();
      Get.delete<AP_Part3Controller>();
      Get.delete<AP_Part4Controller>();
      Get.delete<AP_Part5Controller>();
      Get.delete<ProductMgmtController>();
      Get.delete<BottomNavbarController>();
      c.getProducts(isScrolling: false);
      Get.to(ProductMgmtView());

    }
    isLoading.value = false;
  }

}
