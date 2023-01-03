import 'package:flutter/material.dart';

// employee mgmt page number
class NumberWidget2 extends StatelessWidget {
  String number;
  NumberWidget2(this.number);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.orange,
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
