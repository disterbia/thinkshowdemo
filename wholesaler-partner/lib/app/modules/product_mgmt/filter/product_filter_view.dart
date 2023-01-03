import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/controller/product_mgmt_controller.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/filter/product_filter_controller.dart';
import 'package:wholesaler_partner/app/widgets/category_item_widget.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_chip_widget.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_controller.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_widget.dart';

class ProductMgmtFilterView extends GetView {
  ProductMgmtFilterController ctr = Get.put(ProductMgmtFilterController());
  RangeDatePickerController rangeDatePickerCtr = Get.put(RangeDatePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      bottomNavigationBar: BottomNavBarBuilder(),
      appBar: CustomAppbar(isBackEnable: true, title: '상품관리'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => ctr.isLoading.value
                ? LoadingWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Period_inquiry'.tr,
                        style: MyTextStyles.f16,
                      ),
                      SizedBox(height: 12),
                      // Date Picker
                      RangeDatePicker(
                        startDateController: ctr.startDateController,
                        endDateController: ctr.endDateController,
                        onSubmit: () {
                          ctr.rangeDatePickerSubmit();
                        },
                      ),

                      SizedBox(height: 5),
                      // Chips
                      Obx(
                        () => Wrap(
                          children: [...chipBuilder()],
                        ),
                      ),

                      SizedBox(height: 40),

                      // Select category
                      Text(
                        '카테고리 선택',
                        style: MyTextStyles.f16,
                      ),
                      SizedBox(height: 10),
                      GridView.count(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 0.99,
                        children: [
                          for (var category in ctr.clothCategories)
                            GestureDetector(
                              onTap: () {
                                category.isSelected!.toggle();
                              },
                              child: CategoryItem(category),
                            ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  BottomNavBarBuilder() {
    return SafeArea(
      child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: CustomButton(
            onPressed: () => ctr.applyFilterPressed(),
            text: '필터 적용',
          )),
    );
  }

  chipBuilder() {
    List<ChipWidget> categoryChips = [];
    // Add ALL chip
    for (int i = 0; i < ctr.categoryDates.length; i++) {
      categoryChips.add(
        ChipWidget(
          isSelected: ctr.selectedCategoryDateIndex.value == i,
          title: ctr.categoryDates[i],
          onTap: () => ctr.chipPressed(i),
        ),
      );
    }
    print('categoryChips length ${categoryChips.length}');

    return categoryChips;
  }
}
