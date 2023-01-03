import 'package:flutter/material.dart';

class MyPageItem extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  MyPageItem({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        child: TextButton(
          onPressed: onPressed,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
