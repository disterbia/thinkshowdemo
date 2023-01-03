import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

class mDialog {
  mDialog({required String title, required String subtitle, required TwoButtons twoButtons}) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title),
              Text(subtitle),
              SizedBox(height: 20),
              twoButtons,
            ],
          ),
        ),
      ),
    );
  }
}
