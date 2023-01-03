import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/main/controllers/user_main_controller.dart';

class UserBottomNavbarView extends StatelessWidget {
  UserMainController userMainCtr = Get.put(UserMainController());
  UserBottomNavbarView();

  double iconSize = 25;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: userMainCtr.tabIndex.value,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: MyColors.black,
      onTap: userMainCtr.changeTabIndex,
      items: <BottomNavigationBarItem>[
        ItemBuilder('home'.tr, 'assets/icons/ic_home.png', 'assets/icons/ic_home_grey.png', 0),
        ItemBuilder('store'.tr, 'assets/icons/ic_store.png', 'assets/icons/ic_store_grey.png', 1),
        ItemBuilder('See_all'.tr, 'assets/icons/ic_moabogi.png', 'assets/icons/ic_moabogi_grey.png', 2),
        ItemBuilder('liked'.tr, 'assets/icons/ic_heart_empty.png', 'assets/icons/ic_heart_empty_grey.png', 3),
        ItemBuilder('My_page'.tr, 'assets/icons/ic_my_page.png', 'assets/icons/ic_my_page_grey.png', 4),
      ],
    );
  }

  BottomNavigationBarItem ItemBuilder(String label, String imgSelected, String imgNotSelected, int itemIndex) {
    return BottomNavigationBarItem(
      icon: userMainCtr.tabIndex.value == itemIndex
          ? Image.asset(
              imgSelected,
              width: 24,
            )
          : Image.asset(
              imgNotSelected,
              width: 24,
            ),
      label: label,
    );
  }
}
