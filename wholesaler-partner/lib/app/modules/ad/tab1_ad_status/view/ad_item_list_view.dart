import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/ad_product_model.dart';
import 'package:wholesaler_partner/app/modules/ad/tab1_ad_status/controller/tab1_ad_status_controller.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';

class AdItemList extends StatelessWidget {
  ExposureAdModel adList;
  int adIndex;
  Tab1AdStatusController ctr = Get.put(Tab1AdStatusController());

  AdItemList(this.adList, this.adIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grey6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(adList.date),
              Spacer(),
              CustomButton(
                backgroundColor: MyColors.grey1,
                borderColor: MyColors.grey1,
                textColor: MyColors.black,
                onPressed: () => ctr.addOrEditAdProductsBtnPressed(adIndex),
                text: '상품변경',
              )
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: adList.adProducts.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  ProductItemHorizontal(product: adList.adProducts[index]),
                  Spacer(),
                  // Delte icon
                  IconButton(
                    onPressed: () => ctr.deleteAdProductBtnPressed(adIndex, index),
                    icon: Icon(Icons.delete_outline_rounded),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
