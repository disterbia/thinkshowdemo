import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/product_inquiry_model.dart';
import 'package:wholesaler_partner/app/modules/product_inquiry_list/controller/product_inquiry_list_controller.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';

class ProductInquiryListView extends GetView<ProductInquiryListController> {
  ProductInquiryListController ctr = Get.put(ProductInquiryListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppbar(isBackEnable: true, hasHomeButton: true, title: 'product_inquiry'.tr),
        body: ctr.isLoading.value
            ? LoadingWidget()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              for (ProductInquiry inquiry in ctr.inquiries) ProductItemHorizontal.inquiry(inquiry: inquiry),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
