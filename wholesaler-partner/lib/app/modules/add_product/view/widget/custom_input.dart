import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

import '../../controller/add_product_controller.dart';

class CustomInput extends GetView<AddProductController> {
  final String label;
  final TextEditingController fieldController;
  final String? prefix;
  final TextInputType keyboardType;
  const CustomInput({Key? key, required this.label, required this.fieldController, this.prefix, this.keyboardType = TextInputType.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.grey1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.width / 2,
              child: Text(
                label,
                style: MyTextStyles.f14.copyWith(color: MyColors.black2),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _textField(keyboardType),
                  SizedBox(width: 10),
                  prefix == null
                      ? SizedBox()
                      : Text(
                          prefix!,
                          style: MyTextStyles.f14.copyWith(color: MyColors.grey10),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _textField(keyboardType) {
    return Expanded(
      child: SizedBox(
        height: 30,
        child: TextField(
          controller: fieldController,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.orange,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              filled: true,
              fillColor: Colors.white),
        ),
      ),
    );
  }
}
