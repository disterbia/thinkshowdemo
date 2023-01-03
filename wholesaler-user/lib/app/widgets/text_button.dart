import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

class mTextButton extends StatelessWidget {
  String text;
  IconData icon;
  VoidCallback onPressed;

  mTextButton.icon({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Text(
        text,
        style: MyTextStyles.f14.copyWith(color: MyColors.black2),
      ),
      label: Icon(
        icon,
        color: MyColors.black2,
        size: 18,
      ),
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
    );
  }
}
