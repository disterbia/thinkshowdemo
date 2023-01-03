import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/widgets/sort_dropdown.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

import '../controllers/dingdong_delivery_controller.dart';

class DingdongDeliveryView extends GetView {
  DingdongDeliveryController ctr = Get.put(DingdongDeliveryController());

  init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctr.callGetProductsAPI(isScrolling: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: false, hasHomeButton: true, title: '띵동 배송'),
      body: SingleChildScrollView(
        controller: ctr.scrollController.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => SortDropDown(
                  items: [SortProductDropDownItem.latest, SortProductDropDownItem.bySales],
                  selectedItem: ctr.selectedSortProductDropDownItem.value,
                  onPressed: (selectedItem) => ctr.sortDropDownChanged(selectedItem),
                ),
              ),
              ProductGridViewBuilder(
                crossAxisCount: 3,
                productHeight: 270,
                products: ctr.products,
                isShowLoadingCircle: ctr.allowCallAPI,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
