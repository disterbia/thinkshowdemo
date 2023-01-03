import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/images.dart';

AppBar MainAppbar({String? title, required bool isBackEnable, IconData? icon, Function()? onPressed, Color? backgroundColor, List<Widget>? actions}) {
  return AppBar(
    centerTitle: true,
    leadingWidth: 100,
    backgroundColor: backgroundColor ?? MyColors.white,
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Container(
        width: 80,
        height: 80,
        child: Image.asset(MyImages.logo),
      ),
    ),
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[],
    ),
    actions: actions,
    elevation: 0,
    titleSpacing: 0.0,
    automaticallyImplyLeading: false,
  );
}
