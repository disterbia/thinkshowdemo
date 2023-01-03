import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/controllers/shopping_controller.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/views/widgets/store_list_builder.dart';

class Tab2BookmarksView extends StatelessWidget {
  Page2StoreListController ctr = Get.put(Page2StoreListController());
  Tab2BookmarksView();
  init()  {
     ctr.getBookmarkedStoreData();
    log('Tab2BookmarksView init');
  }

  @override
  Widget build(BuildContext context) {
    init();
    return StoreListBuilder();
  }
}
