import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/modules/bulletin_detail/controllers/bulletin_detail_controller.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/web_view_widget.dart';

import '../../../models/bulletin_model.dart';

class BulletinDetailView extends GetView<BulletinController> {
  BulletinModel bulletinModel;
  String userType;
  BulletinDetailView({required this.bulletinModel, required this.userType});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BulletinController());
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(isBackEnable: true, title: 'bulletin'.tr),
      body: _body(),
    );
  }

  Widget _body() => WebViewWidget(url: '${mConst.API_BASE_URL}/web/$userType/notice-board/${bulletinModel.id}');
}
