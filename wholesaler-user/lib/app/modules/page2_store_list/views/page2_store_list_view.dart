import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/views/tabs/tab1_ranking_view.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/views/tabs/tab2_bookmarks.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/simple_tab_bar.dart';

class Page2StoreListView extends GetView {
  const Page2StoreListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(isBackEnable: false, title: 'store'.tr),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: SimpleTabBar(
            borderColor: MyColors.white,
            initialIndex: 0,
            tabs: [
              Tab(
                text: 'ranking'.tr,
              ),
              Tab(
                text: 'Favorites'.tr,
              )
            ],
            tabBarViews: [
              Tab1RankingView(),
              Tab2BookmarksView(),
            ],
          ),
        )
      ],
    );
  }
}
