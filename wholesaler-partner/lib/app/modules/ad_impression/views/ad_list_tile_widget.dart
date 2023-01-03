import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/impression_product_model.dart';
import 'package:wholesaler_partner/app/modules/ad_impression/controllers/ad_impression_controller.dart';
import 'package:wholesaler_partner/app/modules/ad_impression/views/ad_list_tile_container_widget.dart';
import 'package:wholesaler_partner/app/modules/ad_impression/views/ad_list_tile_divider_widget.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';

class AdListTile extends StatelessWidget {
  ImpressionProductModel currentProduct;
  String productDate;
  AdImpressionController ctr = Get.put(AdImpressionController());
  AdListTile(this.currentProduct, this.productDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ProductItemHorizontal(
            product: currentProduct.productInformation,
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            height: 62,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AdListTileContainer('impressions'.tr, '${currentProduct.expressionCount}회'),
                    AdListTileDivider(),
                    AdListTileContainer('clicks'.tr, '${currentProduct.clickCount}회'),
                    AdListTileDivider(),
                    AdListTileContainer('click_rate'.tr, '${currentProduct.clickRate}%'),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    AdListTileContainer('number_of_likes'.tr, '${currentProduct.likeCount}회'),
                    AdListTileDivider(),
                    AdListTileContainer('purchase_conversion_rate'.tr, '${currentProduct.orderRate}%'),
                    AdListTileDivider(),
                    AdListTileContainer('total_advertising_cost'.tr, '${currentProduct.totalCost}원'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
