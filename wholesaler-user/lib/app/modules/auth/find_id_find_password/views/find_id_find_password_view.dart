import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/auth/find_id_find_password/controllers/find_user_id_controller.dart';
import 'package:wholesaler_user/app/modules/auth/find_id_find_password/widgets/find_user_id.dart';
import 'package:wholesaler_user/app/modules/auth/find_id_find_password/widgets/find_user_password.dart';
import 'package:wholesaler_user/app/modules/main/controllers/user_main_controller.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/simple_tab_bar.dart';

class User_FindID_FindPasswordView extends GetView<User_FindID_FindPasswordController> {
  User_FindID_FindPasswordController ctr = Get.put(User_FindID_FindPasswordController());
  UserMainController u =Get.put(UserMainController());


  User_FindID_FindPasswordView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(isBackEnable: true, title: '계정 찾기'),
      body: _userIdBody(),
    );
  }

  Widget _userIdBody() {
    return Column(
      children: [
        Expanded(
          child: SimpleTabBar(
            tabs: ctr.userIdTabs,
            initialIndex: ctr.initialIndex.value,
            tabBarViews: [
              Tab1FindUserIdView(),
              Tab2FindUserPasswordView(),
            ],
          ),
        )
      ],
    );
  }
}
