import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/change_number/view/change_number_view.dart';
import 'package:wholesaler_partner/app/modules/page3_my_info_mgmt/views/my_page_down.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/modules/auth/find_id_find_password/views/find_id_find_password_view.dart';
import 'package:wholesaler_user/app/modules/main/controllers/user_main_controller.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

import '../../../widgets/loading_widget.dart';
import '../../../widgets/my_page_item.dart';
import '../controllers/my_info_mgmt_controller.dart';

class MyInfoMgmtView extends GetView<MyInfoMgmtController> {
  UserMainController c = Get.put(UserMainController());
  MyInfoMgmtController ctr = Get.put(MyInfoMgmtController());
  int myTest=0;
  @override
  Widget build(BuildContext context) {
    myTest=0;
    return Obx(() {
      return Scaffold(
        appBar: CustomAppbar(isBackEnable: true, title: '내 정보 관리'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60),
                // TOP Image and store
                ctr.isLoading.value ? LoadingWidget() : _topStore(ctr),
                SizedBox(height: 30),
                // Divider
                SizedBox(
                  width: double.infinity,
                  height: 3,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(color: MyColors.grey3),
                  ),
                ),
                MyPageItem(
                  title: '비밀번호 찾기',
                  onPressed: () {
                    Get.to(() => User_FindID_FindPasswordView(), arguments: FindIDPasswordTabIndex.findPassword.index);
                  },
                ),
                Divider(),
                MyPageItem(
                  title: '휴대폰번호 변경',
                  onPressed: () {
                    Get.to(() => ChangeNumberView());
                  },
                ),
                // Divider(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _topStore(MyInfoMgmtController ctr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // IMAGE
        Stack(
          children: [
            Container(
              height: 101,
              width: 101,
              child: GestureDetector(
                onTap: ctr.uploadImageBtnPressed,
                child: ctr.uploadedImageURL.isEmpty && ctr.store!.imgUrl == null
                    ? CircleAvatar(
                        backgroundColor: MyColors.grey1,
                        child: Icon(
                          Icons.image_rounded,
                          color: MyColors.black,
                        ),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(ctr.uploadedImageURL.value.isNotEmpty ? ctr.uploadedImageURL.value : ctr.store!.imgUrl!.value),
                      ),
              ),
            ),
            if (ctr.isUploadLoading.value) Container(height: 101, width: 101, child: LoadingWidget()),
          ],
        ),
        SizedBox(width: 20),
        // Text: Store name, user ID
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(onDoubleTap:() {
                  myTest++;
                  if(myTest==20){
                    Get.to(()=>MyPageDownP());
                  }
                },
                  child: Text(
                    ctr.store!.name!,
                    style: MyTextStyles.f18_bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  CacheProvider().getUserID(),
                  style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(CacheProvider().isOwner() ? "대표" : '직원'),
          ],
        ),
      ],
    );
  }
}
