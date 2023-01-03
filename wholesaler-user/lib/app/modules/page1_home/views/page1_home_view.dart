import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab1_home.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab2_best.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab3_new_products.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab4_ding_dong.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab5_ding_pick.dart';
import 'package:wholesaler_user/app/modules/search/views/search_page_view.dart';
import 'package:wholesaler_user/app/widgets/main_appbar.dart';
import 'package:wholesaler_user/app/widgets/simple_tab_bar.dart';

class Page1HomeView extends GetView<Page1HomeController> {
  Page1HomeController ctr = Get.put(Page1HomeController());
  Page1HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mainAppbar(),
      backgroundColor: MyColors.white,
      body: _floatTabBar(),
    );
  }

  Widget _floatTabBar() {
    return SimpleTabBar(
      initialIndex: ctr.tabBarIndex.value,
      borderColor: MyColors.white,
      tabs: [Tab(text: 'home'.tr), Tab(text: 'best'.tr), Tab(text: 'new'.tr), Tab(text: 'Dingdong'.tr), Tab(text: 'dingpick'.tr)],
      tabBarViews: [
        Tab1HomeView(),
        Tab2BestView(),
        Tab3NewProductsView(),
        Tab4DingDongView(),
        Tab5DingPickView(),
      ],
    );
  }

  AppBar _mainAppbar() {
    return MainAppbar(
      isBackEnable: false,
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: MyColors.black,
          ),
          onPressed: () {
            Get.to(() => SearchPageView());
          },
        ),
        IconButton(
            onPressed: () {
              Get.to(() => Cart1ShoppingBasketView());
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: MyColors.black,
            ))
      ],
    );
  }
}
