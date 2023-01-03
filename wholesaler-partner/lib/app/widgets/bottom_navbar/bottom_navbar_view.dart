import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/bottom_navbar/bottom_navbar_controller.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:get/get.dart';

class PartnerBottomNavbarView extends StatelessWidget {
  const PartnerBottomNavbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navbarCtr = Get.put(BottomNavbarController());

    return Obx(() => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined),
              label: 'orderHistory'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'myPage'.tr,
            ),
          ],
          currentIndex: navbarCtr.tabIndex.value,
          selectedItemColor: MyColors.black,
          onTap: (index) {
            navbarCtr.updateNavBar(index);
          },
        ));
  }
}
