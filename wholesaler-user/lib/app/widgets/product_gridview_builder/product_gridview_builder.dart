// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder_controller.dart';

class ProductGridViewBuilder extends StatelessWidget {
  // ProductGridViewBuilderController ctr = Get.put(ProductGridViewBuilderController());

  int crossAxisCount;
  int productHeight;
  RxList<Product> products;
  void Function(int)? addProductsId;
  VoidCallback? showBottomNavbar; // 상품관리 product mgmt page -> bottom navbar
  List<ProductNumber>? productNumbers;
  RxBool isShowLoadingCircle;

  ProductGridViewBuilder({
    required this.crossAxisCount,
    required this.productHeight,
    required this.products,
    this.addProductsId,
    this.showBottomNavbar,
    this.productNumbers,
    required this.isShowLoadingCircle,
  });

  @override
  Widget build(BuildContext context) {
    double columnWidth = context.width / crossAxisCount;
    return Obx(() => Column(
          children: [
            GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductItemVertical(
                  product: products[index],
                  productNumber: productNumbers != null ? productNumbers![index > 9 ? 9 : index] : null,
                  onCheckboxChanged: (newValue) {
                    products[index].isChecked!.toggle();
                    showBottomNavbar!();
                    addProductsId!(products[index].id);
                  },
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                crossAxisCount: crossAxisCount,
                childAspectRatio: columnWidth /
                    (MyVars.isSmallPhone()
                        ? (productHeight + 10)
                        : productHeight), // explanation: add productheight +10 for small screen sizes, if we don't, on small screen the product height is too short
              ),
            ),
            Obx(() => isShowLoadingCircle.isTrue
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox.shrink()),
          ],
        ));
  }
}
