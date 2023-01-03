import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  final IconData iconData;
  final BorderRadius leftBtnBorder;
  final VoidCallback onTap;
  const QuantityButton(this.iconData, this.leftBtnBorder, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency, //Makes it usable on any background color, thanks @IanSmith
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: leftBtnBorder,
          ),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                iconData,
                size: 12,
              ),
            ),
          ),
        ));
  }
}
