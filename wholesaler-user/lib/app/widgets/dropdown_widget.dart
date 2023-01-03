import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/models/product_option_model.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/utils/utils.dart';

class mOptionDropDownButton extends StatelessWidget {
  ProductDetailController ctr = Get.put(ProductDetailController());

  final String label;
  final List<ProductOptionModel> options;
  mOptionDropDownButton({
    required this.label,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton(
        hint: Text(label),
        value: ctr.selectedOptionIndex.value == -1 ? null : ctr.product.value.options![ctr.selectedOptionIndex.value],
        items: itemsBuilder(),
        onChanged: (ProductOptionModel? newOption) {
          if (!newOption!.is_sold_out!) {
            ctr.selectedOptionIndex.value = ctr.product.value.options!.indexOf(newOption);
            ctr.UpdateTotalPrice();
          }
        },
      ),
    );
  }

  List<DropdownMenuItem<ProductOptionModel>> itemsBuilder() {
    return options.map<DropdownMenuItem<ProductOptionModel>>((ProductOptionModel option) {
    //  print('option.is_sold_out! ${option.is_sold_out}');
      String frontText = '';
      if (option.add_price! == 0) {
        frontText = '';
      } else {
        frontText = '   (+${Utils.numberFormat(number: option.add_price!)})';
      }

      if (option.is_sold_out! == true) {
        frontText = '   품절';
      }

      return DropdownMenuItem<ProductOptionModel>(
        value: option,
        child: Text(
          option.name! + frontText,
          style: option.is_sold_out! ? TextStyle(color: MyColors.grey2) : null,
        ),
      );
    }).toList();
  }
}
