import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/data/firebase_service.dart';
import 'package:wholesaler_user/app/modules/page3_moabogi/views/page3_moabogi_view.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/page1_home_view.dart';
import 'package:wholesaler_user/app/modules/page4_favorite_products/views/page4_favorite_products_view.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/views/page2_store_list_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/views/page_5_my_Page_view.dart';
import 'package:wholesaler_user/app/widgets/bottom_navbar/bottom_navbar_view.dart';
import '../controllers/user_main_controller.dart';

class UserMainView extends GetView<UserMainController> {
  UserMainController ctr = Get.put(UserMainController());
  UserMainView();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions = <Widget>[
    Page1HomeView(),
    Page2StoreListView(),
    Page3MoabogiView(),
    Page4FavoriteProductsView(isRecentSeenProduct: false),
    Page5MyPageView(),
  ];

  @override
  Widget build(BuildContext context) {
    FirebaseService.init();
    return WillPopScope(
      onWillPop: () => ctr.onWillPop(),
      child: Scaffold(
        body: Obx(
          () => Center(
            child: widgetOptions.elementAt(ctr.tabIndex.value),
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              ItemBuilder('home'.tr, 'assets/icons/ic_home.png',
                  'assets/icons/ic_home_grey.png', 0),
              ItemBuilder('store'.tr, 'assets/icons/ic_store.png',
                  'assets/icons/ic_store_grey.png', 1),
              ItemBuilder('See_all'.tr, 'assets/icons/ic_moabogi.png',
                  'assets/icons/ic_moabogi_grey.png', 2),
              ItemBuilder('liked'.tr, 'assets/icons/ic_heart_empty.png',
                  'assets/icons/ic_heart_empty_grey.png', 3),
              ItemBuilder('My_page'.tr, 'assets/icons/ic_my_page.png',
                  'assets/icons/ic_my_page_grey.png', 4),
            ],
            currentIndex: ctr.tabIndex.value,
            onTap: ctr.changeTabIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: MyColors.black,
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem ItemBuilder(
      String label, String imgSelected, String imgNotSelected, int itemIndex) {
    return BottomNavigationBarItem(
      icon: ctr.tabIndex.value == itemIndex
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
