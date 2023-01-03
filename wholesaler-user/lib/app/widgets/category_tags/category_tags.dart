import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/cloth_category_model.dart';
import 'package:wholesaler_user/app/modules/page3_product_category_page/view/product_category_page_view.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_chip_widget.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';

class HorizontalChipList {
  CategoryTagController ctr = Get.put(CategoryTagController());

  // ############ Cloth categories
  Widget getAllMainCat({required List<String> categoryList, required Function() onTapped}) {
    List<ChipWidget> categoryChips = [];
    // Add ALL chip
    categoryChips.add(
      ChipWidget(
          title: ctr.isDingDongTab.isTrue ? "인기" : ClothCategory.ALL,
          onTap: () {
            ctr.selectedMainCatIndex.value = 0;
            onTapped();
          },
          isSelected: 0 == ctr.selectedMainCatIndex.value ? true : false),
    );

    // Add main or sub categories: ex: shirt,
    for (int i = 0; i < categoryList.length; i++) {
      categoryChips.add(
        ChipWidget(
            title: categoryList[i],
            onTap: () {
              ctr.selectedMainCatIndex.value = i + 1; // the reason for i+1 instead of i: i==0 is "ALL" chip
              onTapped();
            },
            isSelected: (i + 1) == ctr.selectedMainCatIndex.value ? true : false),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [...categoryChips],
      ),
    );
  }

  Widget getAllSubcat({required List<ClothCategoryModel> subCatList, required Function(ClothCategoryModel) onTapped, required int parentId}) {
    List<ChipWidget> categoryChips = [];
    // Add ALL chip
    ClothCategoryModel allClothCatModel = ClothCategoryModel(id: parentId, name: ClothCategory.ALL, parentId: parentId, depth: 0, isUse: false);
    categoryChips.add(
      ChipWidget(
          title: ClothCategory.ALL,
          onTap: () {
            ctr.selectedMainCatIndex.value = 0;
            onTapped(allClothCatModel);
          },
          isSelected: 0 == ctr.selectedMainCatIndex.value ? true : false),
    );

    // Add main or sub categories: ex: shirt,
    for (int i = 0; i < subCatList.length; i++) {
      categoryChips.add(
        ChipWidget(
            title: subCatList[i].name,
            onTap: () {
              ctr.selectedMainCatIndex.value = i + 1; // the reason for i+1 instead of i: i==0 is "ALL" chip
              onTapped(subCatList[i]);
            },
            isSelected: (i + 1) == ctr.selectedMainCatIndex.value ? true : false),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [...categoryChips],
      ),
    );
  }

  Widget getIconTextList({required Function(int) onPressed}) {
    double screenWidth = MediaQuery.of(Get.context!).size.width;

    List<ClothCategory> clothCategories = ClothCategory.getAll();
    return Container(
      alignment: Alignment.center,
      width: screenWidth,
      height: 98,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemCount: clothCategories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ClothCategoryItemBuilder(
              clothCategory: clothCategories.elementAt(index),
              height: screenWidth / clothCategories.length - 25,
              width: screenWidth / clothCategories.length - 25,
              onTap: () => onPressed(index),
            );
          }),
    );
  }

  Widget ClothCategoryItemBuilder({required ClothCategory clothCategory, required VoidCallback onTap, required double height, required double width}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                clothCategory.icon,
                height: height,
                width: width,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 5),
            Text(
              clothCategory.title,
              style: MyTextStyles.f12.copyWith(color: MyColors.grey2),
            ),
          ],
        ),
      ),
    );
  }
}
