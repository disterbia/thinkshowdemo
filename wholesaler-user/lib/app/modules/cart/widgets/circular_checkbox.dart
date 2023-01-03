import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';

class CircularCheckbox extends StatelessWidget {
  Function(bool) onChanged;
  // cartId, productId, if null: it is selected all checkbox
  int? cartIndex;
  int? productIndex;
  bool isChecked;
  CircularCheckbox({this.cartIndex, this.productIndex, required this.isChecked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24, // this is not real width. real width is defined by the Transform.scale value
      height: 24, // this is not real height. real height is defined by the Transform.scale value
      child: Transform.scale(
        scale: 1.3,
        child: Checkbox(
          checkColor: Colors.white,
          activeColor: MyColors.primary,
          value: isChecked,
          shape: CircleBorder(),
          onChanged: (bool? value) => onChanged(value!),
        ),
      ),
    );
  }
}
