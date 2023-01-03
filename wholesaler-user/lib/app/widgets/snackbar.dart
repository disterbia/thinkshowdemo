import 'package:flutter/material.dart';
import 'package:get/get.dart';

mSnackbar({required String message, String? actionText, VoidCallback? onPressed, int duration = 2}) {
  final snackBar = SnackBar(
    content: Text(message),
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
    action: SnackBarAction(
      label: actionText ?? '',
      onPressed: onPressed ?? () {},
    ),
    duration: Duration(seconds: duration),
  );
  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}
