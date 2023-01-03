import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/add_product/controller/add_product_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/part1_clothes_category/controller/cloth_category_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/add_product_view.dart';
import 'package:wholesaler_user/app/models/cloth_category_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class ClothCategoryItemsView extends StatelessWidget {
  ClothCategoryController ctr = Get.put(ClothCategoryController());
  ClothCategory clothCategory;
  ClothCategoryItemsView(this.clothCategory);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: '상품등록', isBackEnable: true),
      body: body(),
    );
  }

  Widget body() {
    return ListView(
      children: [
        categoryTitle(),
        for (ClothCategoryModel subCat in clothCategory.subCategories) _itemBuilder(subCat),
      ],
    );
  }

  Widget categoryTitle() {
    return ListTile(
      title: Text(clothCategory.title),
      leading: Image.asset(
        clothCategory.icon,
        width: 40,
        height: 40,
      ),
    );
  }

  Widget _itemBuilder(ClothCategoryModel subCat) {
    return ListTile(
      onTap: () => ctr.clothCategorySelected(subCat, clothCategory),
      title: Text(subCat.name),
    );
  }
}
