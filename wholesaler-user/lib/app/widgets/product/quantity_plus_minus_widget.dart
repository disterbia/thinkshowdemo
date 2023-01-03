import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wholesaler_user/app/widgets/product/quantity_plus_minus_button_widget.dart';

class QuantityPlusMinusWidget extends StatelessWidget {
  Function(bool isRightTapped) onTap;
  int quantity;

  QuantityPlusMinusWidget({required this.quantity, required this.onTap});

  BorderRadius rightRoundBorder = BorderRadius.only(
    topRight: Radius.circular(4),
    bottomRight: Radius.circular(4),
  );

  BorderRadius leftRoundBorder = BorderRadius.only(
    topLeft: Radius.circular(4),
    bottomLeft: Radius.circular(4),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuantityButton(FontAwesomeIcons.minus, leftRoundBorder, (() => onTap(false))),
        Container(
          alignment: Alignment.center,
          width: 48,
          height: 24,
          child: Text(
            quantity.toString(),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
        ),
        QuantityButton(FontAwesomeIcons.plus, rightRoundBorder, (() => onTap(true)))
      ],
    );
  }
}
