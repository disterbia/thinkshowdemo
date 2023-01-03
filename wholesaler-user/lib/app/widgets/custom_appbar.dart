import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/main/view/partner_main_view.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/main/view/user_main_view.dart';

AppBar CustomAppbar(
    {String? title,
    required bool isBackEnable,
    bool? hasHomeButton,
    // IconData? icon,
    Function()? onPressed,
    Color? backgroundColor,
    List<Widget>? actions,
    bool isOffAllHome = false}) {
  return AppBar(
    centerTitle: true,
    leadingWidth: 100,
    backgroundColor: backgroundColor ?? MyColors.white,
    title: Text(
      title.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(color: MyColors.black),
    ),
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Back icon
        if (isBackEnable)
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: MyColors.black,
              size: 20,
            ),
            splashColor: Colors.white,
            onPressed: () {
              if (isOffAllHome) {
                Get.offAll(() => PartnerMainView());
              } else {
                Get.back();
              }
            },
          ),
        // Home button
        hasHomeButton != null && hasHomeButton == true
            ? Container(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: () {
                    Get.offAll(() => MyVars.isUserProject()
                        ? UserMainView()
                        : PartnerMainView());
                  },
                  icon: Image.asset('assets/icons/ic_home.png'),
                ),
              )
            : SizedBox.shrink(),
      ],
    ),
    actions: actions,
    elevation: 0.9,
    titleSpacing: 0.0,
    automaticallyImplyLeading: false,
  );
}
