import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';

class NumberWidget extends StatelessWidget {
  ProductNumber productNumber;

  NumberWidget(this.productNumber);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 20,
      margin: EdgeInsets.only(top: 20, left: 2),
      decoration: BoxDecoration(
        color: productNumber.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Center(
        child: Text(
          productNumber.number.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
