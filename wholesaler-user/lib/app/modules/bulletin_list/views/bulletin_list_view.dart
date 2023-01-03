import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/bulletin_detail/views/bulletin_detail_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

import '../controllers/bulletin_list_controller.dart';

class BulletinListView extends GetView<BulletinListController> {
  BulletinListController ctr = Get.put(BulletinListController());

  @override
  Widget build(BuildContext context) {
    return GetX<BulletinListController>(initState: (state) {
      Get.find<BulletinListController>().getBulletins();
    }, builder: (_) {
      return Scaffold(
        appBar: CustomAppbar(isBackEnable: true, title: 'bulletin'.tr),
        body: ctr.isLoading.value
            ? LoadingWidget()
            : SingleChildScrollView(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ctr.bulletins.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Get.to(
                          () => BulletinDetailView(
                            userType: 'user',
                            bulletinModel: ctr.bulletins[index],
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColors.grey6),
                            color: MyColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(MyDimensions.radius),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ctr.bulletins[index].createdAt.toString(),
                                  style: MyTextStyles.f12.copyWith(color: MyColors.grey8),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  ctr.bulletins[index].title.toString(),
                                  style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
      );
    });
  }
}
