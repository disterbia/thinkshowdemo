import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

class AdListTileContainer extends StatelessWidget {
  String firstText;
  String lastText;

  AdListTileContainer(this.firstText, this.lastText);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Row(
          children: [
            Text(
              firstText,
              style: MyTextStyles.f9,
            ),
            Spacer(),
            Text(
              lastText,
              style: MyTextStyles.f9,
            ),
          ],
        ),
      ),
    );
  }
}
