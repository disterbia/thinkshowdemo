import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab2_best_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class Tab2BestView extends GetView<Tab2BestController> {
  Tab2BestController ctr = Get.put(Tab2BestController());
  Tab2BestView();

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> ctr.isLoading.value?LoadingWidget():SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Obx(() => HorizontalChipList().getAllMainCat(
                  categoryList:
                      ClothCategory.getAllMainCat().map((e) => e.name).toList(),
                  onTapped: () async{
                    await ctr.updateProducts();
                  })),
            ),
            SizedBox(height: 5),
            _button(),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ProductGridViewBuilder(
                crossAxisCount: 2,
                productHeight: 360,
                products: ctr.products,
                isShowLoadingCircle: ctr.allowCallAPI,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () => DropdownButton(
              hint: Text(ctr.dropdownItems[ctr.selectedDropdownIndex.value]),
              items: itemsBuilder(ctr.dropdownItems),
              onChanged: (String? newValue) {
                log('$newValue');
                ctr.selectedDropdownIndex.value =
                    ctr.dropdownItems.indexOf(newValue!);
                ctr.updateProducts();
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> itemsBuilder(List<String> itemStrings) {
    return itemStrings.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
