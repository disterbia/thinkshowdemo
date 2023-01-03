import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/page1_home/controller/partner_home_controller.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/widgets/dingdong_3products_horiz/dingdong_3products_horiz_controller.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';

class Dingdong3ProductsHorizView extends GetView<Dingdong3ProductsHorizController> {
  Dingdong3ProductsHorizController ctr = Get.put(Dingdong3ProductsHorizController());

  Dingdong3ProductsHorizView();

  @override
  Widget build(BuildContext context) {
    double leftPadding = 10;
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Container(
        height: 240,
        child: Obx(
          () => ctr.dingDongProducts.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: false,
                  itemCount: ctr.dingDongProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: (context.width / 3) - leftPadding,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MyVars.isSmallPhone() ? 3 : 0),
                        child: ProductItemVertical(
                          product: ctr.dingDongProducts.elementAt(index),
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text('제품을 등록해주세요.')),
        ),
      ),
    );
  }
}
