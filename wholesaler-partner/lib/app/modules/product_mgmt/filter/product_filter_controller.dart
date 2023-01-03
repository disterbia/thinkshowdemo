import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/controller/product_mgmt_controller.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/view/product_mgmt_view.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_controller.dart';

class ProductMgmtFilterController extends GetxController {
  ProductMgmtController productMgmtCtr = Get.put(ProductMgmtController());
  RangeDatePickerController rangeDatePickerCtr = Get.put(RangeDatePickerController());

  List<String> categoryDates = [ProductFilterDates.sameDay, ProductFilterDates.oneMonth, ProductFilterDates.threeMonth];
  RxInt selectedCategoryDateIndex = 9999.obs;
  List<ClothCategory> clothCategories = ClothCategory.getAll();
  List<int> selectedClothCatIds = [];

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    startDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  void rangeDatePickerSubmit() {
    isLoading.value = true;
    // reset selectedCategoryDateIndex
    selectedCategoryDateIndex.value = 9999;

    // get updated dates from RangeDate Controller
    DateTime tempStartDate = rangeDatePickerCtr.tempStartDate;
    DateTime tempEndDate = rangeDatePickerCtr.tempEndDate;
    print('tempStartDate $tempStartDate');
    print('tempEndDate $tempEndDate');
    startDateController.text = DateFormat('yyyy-MM-dd').format(tempStartDate);
    endDateController.text = DateFormat('yyyy-MM-dd').format(tempEndDate);
    print('ctr.endDateController.value.text ${endDateController.value.text}');
    isLoading.value = false;
  }

  void applyFilterPressed() async{
    print('selected dates: ${startDateController.text} ~ ${endDateController.text}');
    for (int i = 0; i < clothCategories.length; i++) {
      if (clothCategories[i].isSelected!.value == true) {
        selectedClothCatIds.add(clothCategories[i].id);
        print('title: ${clothCategories[i].title} id: ${clothCategories[i].id}');
      }
    }
    // check if 당일, 1개월, 3개월 is selected
    if (selectedCategoryDateIndex.value != 9999) {
      DateTime today = DateTime.now();
      // same day 당일
      if (categoryDates[selectedCategoryDateIndex.value] == ProductFilterDates.sameDay) {
        print('same day');
        endDateController.text = DateFormat('yyyy-MM-dd').format(today);
        startDateController.text = DateFormat('yyyy-MM-dd').format(today);
      }
      // 1 month 1개월
      else if (categoryDates[selectedCategoryDateIndex.value] == ProductFilterDates.oneMonth) {
        print('one month');
        endDateController.text = DateFormat('yyyy-MM-dd').format(today);
        DateTime oneMonth = DateTime(today.year, today.month - 1, today.day);
        startDateController.text = DateFormat('yyyy-MM-dd').format(oneMonth);
      }
      // 3 month 3개월
      else if (categoryDates[selectedCategoryDateIndex.value] == ProductFilterDates.threeMonth) {
        print('three month');
        endDateController.text = DateFormat('yyyy-MM-dd').format(today);
        DateTime threeMonth = DateTime(today.year, today.month - 3, today.day);
        startDateController.text = DateFormat('yyyy-MM-dd').format(threeMonth);
      }
    }

   await productMgmtCtr.getProductsWithFilter(startDate: startDateController.text, endDate: endDateController.text, clothCatIds: selectedClothCatIds);
     Get.back();
   // Get.to(ProductMgmtView());
  }

  chipPressed(int i) {
    isLoading.value = true;
    selectedCategoryDateIndex.value = i;
    // change range date picker start and end dates
    if (categoryDates[i] == ProductFilterDates.sameDay) {
      startDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
      endDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else if (categoryDates[i] == ProductFilterDates.oneMonth) {
      startDateController.text = DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day));
      endDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else if (categoryDates[i] == ProductFilterDates.threeMonth) {
      startDateController.text = DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day));
      endDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
    isLoading.value = false;
  }
}
