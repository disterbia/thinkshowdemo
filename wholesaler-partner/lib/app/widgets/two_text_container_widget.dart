import 'package:flutter/material.dart';

class TwoTextContainer extends StatelessWidget {
  String topText;
  String bottomText;
  TwoTextContainer({required this.topText, required this.bottomText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(topText),
          SizedBox(height: 4),
          Text(bottomText),
        ],
      ),
    );
  }
}
