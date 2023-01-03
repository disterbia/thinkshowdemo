import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/product_body_size_model.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/size_category.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/size_child.dart';
import 'package:wholesaler_partner/app/models/product_modify_model/size_info_list.dart';
import 'package:wholesaler_partner/app/modules/add_product/controller/add_product_controller.dart';

class AP_Part2Controller extends GetxController {
  AddProductController addProductCtr = Get.put(AddProductController());

  RxBool unitPriceCheckbox = true.obs;
  RxBool isOptionCheckbox = true.obs;

  RxList<ProductBodySizeModel> productBodySizeList = <ProductBodySizeModel>[].obs;

  // This list of controllers can be used to set and get the text from/to the TextFields
  Map<String, TextEditingController> textEditingControllers = {};

  createProductBodySizeList(int? id) {
    List<String> sizes = ['FREE', 'XS', 'S', 'M', 'L'];

    productBodySizeList.clear();

    if (addProductCtr.isEditing.isTrue) {
      for (int i = 0; i < sizes.length; i++) {
        // if is selected:
        if (addProductCtr.productModifyModel.value.sizeInfoList!.any((element) => element.size == sizes[i])) {
          SizeInfoModel tempSizeInfo = addProductCtr.productModifyModel.value.sizeInfoList!.firstWhere((element) => element.size == sizes[i]);
          productBodySizeList.add(
            ProductBodySizeModel(
              size: tempSizeInfo.size!,
              isSelected: true.obs,
              clothMainCategory: addProductCtr.productModifyModel.value.mainCategoryId!,
              sizeCategory: SizeCategory.getWithCatId(addProductCtr.productModifyModel.value.mainCategoryId!),
            ),
          );
        }
        // if is not selected:
        else {
          productBodySizeList.add(
            ProductBodySizeModel(
              size: sizes[i],
              isSelected: false.obs,
              clothMainCategory: addProductCtr.productModifyModel.value.mainCategoryId!,
              sizeCategory: SizeCategory.getWithCatId(addProductCtr.productModifyModel.value.mainCategoryId!),
            ),
          );
        }
      }
    } else {
      for (int i = 0; i < sizes.length; i++) {
        productBodySizeList.add(
          ProductBodySizeModel(
            size: sizes[i],
            isSelected: false.obs,
            clothMainCategory: id!,
            sizeCategory: SizeCategory.getWithCatId(id),
          ),
        );
      }
    }
  }

  sizetableFieldChanged({required String value, required int productBodySizeListIndex, required int sizeCategoryIndex}) {
    if (value.isEmpty) {
      return;
    }
    // print('sizetableFieldChanged: sizeCategoryIndex: $sizeCategoryIndex productBodySizeListIndex: $productBodySizeListIndex value: $value');

    // if (productBodySizeList[productBodySizeListIndex].isSelected.value) {
    //   productBodySizeList[productBodySizeListIndex].sizeCategory.seunghanTestValue = int.parse(value);
    // }
  }

  void sizeFieldInitialize({required int productBodySizeListIndex, required int sizeCategoryIndex}) {
    // check if is editing or adding new product
    var textEditingController = TextEditingController(text: '');

    if (addProductCtr.isEditing.value && !addProductCtr.isChangeCategoryInEditeMode.value) {
      String currentSizeStr = productBodySizeList[productBodySizeListIndex].size;
      for (int i = 0; i < addProductCtr.productModifyModel.value.sizeInfoList!.length; i++) {
        // filter 1: sizes example Free, S, M, L
        if (currentSizeStr == addProductCtr.productModifyModel.value.sizeInfoList![i].size) {
          // print('currentSizeStr   : $currentSizeStr');
          // filter 2: sizeCategoryIndex example 0, 1, 2, 3, 4
          String currentSizeCategoryEnglishStr = productBodySizeList[productBodySizeListIndex].sizeCategory.children[sizeCategoryIndex].english;
          // print('currentSizeCategoryEnglishStr $currentSizeCategoryEnglishStr');
          SizeInfoModel sizeList = addProductCtr.productModifyModel.value.sizeInfoList![i];

          if (currentSizeCategoryEnglishStr == SizeChild.arm_cross_length.english && sizeList.armCrossLength != null) {
            textEditingController.text = sizeList.armCrossLength.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.arm_straight_length.english && sizeList.armStraightLength != null) {
            textEditingController.text = sizeList.armStraightLength.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.armhole.english && sizeList.armhole != null) {
            textEditingController.text = sizeList.armhole.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.bottom_cross_length.english && sizeList.bottomCrossLength != null) {
            textEditingController.text = sizeList.bottomCrossLength.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.bottom_top_cross_length.english && sizeList.bottomTopCrossLength != null) {
            textEditingController.text = sizeList.bottomTopCrossLength.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.chest_cross_length.english && sizeList.chestCrossLength != null) {
            textEditingController.text = sizeList.chestCrossLength.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.hip_cross_length.english && sizeList.hipCrossLength != null) {
            textEditingController.text = sizeList.hipCrossLength.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.lining.english && sizeList.lining != null) {
            textEditingController.text = sizeList.lining.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.open.english && sizeList.open != null) {
            textEditingController.text = sizeList.open.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.shoulder_cross_length.english && sizeList.shoulderCrossLength != null) {
            textEditingController.text = sizeList.shoulderCrossLength.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.sleeve_cross_length.english && sizeList.sleeveCrossLength != null) {
            textEditingController.text = sizeList.sleeveCrossLength.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.strap.english && sizeList.strap != null) {
            textEditingController.text = sizeList.strap.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.total_entry_length.english && sizeList.totalEntryLength != null) {
            textEditingController.text = sizeList.totalEntryLength.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.waist_cross_length.english && sizeList.waistCrossLength != null) {
            textEditingController.text = sizeList.waistCrossLength.toString();
          } else if (currentSizeCategoryEnglishStr == SizeChild.thigh_cross_length.english && sizeList.thighCrossLength != null) {
            textEditingController.text = sizeList.thighCrossLength.toString();
          }
        }
      }
    }

    textEditingControllers.putIfAbsent(productBodySizeListIndex.toString() + sizeCategoryIndex.toString(), () => textEditingController);
  }
}
