import 'package:flutter/material.dart';

class IconTextContainer extends StatelessWidget {
  String title;
  IconData icon;

  IconTextContainer({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(icon),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
        SizedBox(height: 3),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
