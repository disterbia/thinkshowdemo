// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/user_model.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/views/my_Page_settings_view.dart';

class TopUserIDUserNameSettings extends StatelessWidget {
  User user;
  bool showSettingsIcon;
  TopUserIDUserNameSettings({required this.user, required this.showSettingsIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User ID
            Text(
              user.userID,
              style: MyTextStyles.f16.copyWith(color: MyColors.black3),
            ),
            SizedBox(height: 5),
            // User Name
            Text(
              user.userName,
              style: MyTextStyles.f12.copyWith(color: MyColors.black2),
            )
          ],
        ),
        Spacer(),
        // Settings Icon
        showSettingsIcon
            ? IconButton(
                onPressed: () {
                  Get.to(() => MyPageSettingsView());
                },
                icon: Image.asset('assets/icons/ic_settings.png'),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
