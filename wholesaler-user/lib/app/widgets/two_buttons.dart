import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';

import 'custom_button.dart';

class TwoButtons extends StatelessWidget {
  final String rightBtnText;
  final String leftBtnText;
  final Function() rBtnOnPressed;
  final Function() lBtnOnPressed;
  final bool? isLoadingRight;
  final bool? isLoadingLeft;

  const TwoButtons({required this.leftBtnText, required this.rightBtnText, required this.lBtnOnPressed, required this.rBtnOnPressed, this.isLoadingRight, this.isLoadingLeft});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: isLoadingLeft ?? false ? LoadingWidget() : CustomButton(
            textColor: MyColors.grey2,
            onPressed: lBtnOnPressed,
            text: leftBtnText,
            backgroundColor: MyColors.white,
            borderColor: MyColors.primary,
            fontSize: 14,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: isLoadingRight ?? false ? LoadingWidget() : CustomButton(
            onPressed: rBtnOnPressed,
            text: rightBtnText,
            backgroundColor: MyColors.primary,
            borderColor: MyColors.primary,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
