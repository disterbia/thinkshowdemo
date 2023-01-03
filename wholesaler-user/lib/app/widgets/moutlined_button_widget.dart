import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

class mOutlinedButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  mOutlinedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: MyTextStyles.f14.copyWith(color: MyColors.grey8),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(3),
        side: BorderSide(width: 1, color: MyColors.primary),
      ),
    );
  }
}
