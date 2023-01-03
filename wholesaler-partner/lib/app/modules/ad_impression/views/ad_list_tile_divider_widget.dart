import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

class AdListTileDivider extends StatelessWidget {
  const AdListTileDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '|',
        style: MyTextStyles.f9,
      ),
    );
  }
}
