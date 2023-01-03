import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/point_mgmt/controllers/point_mgmt_controller.dart';
import 'package:wholesaler_user/app/modules/point_mgmt/widgets/point_listview_item_widget.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_widget.dart';

class PointMgmtView extends GetView {
  PointMgmtController ctr = Get.put(PointMgmtController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: true, title: '포인트'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 34),
              Row(
                children: [
                  Text(
                    '포인트',
                    style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Obx(
                        () => Text(
                          Utils.numberFormat(number: ctr.totalPoints.value),
                          style: MyTextStyles.f18_bold.copyWith(color: MyColors.black3),
                        ),
                      ),
                      Text(
                        'P',
                        style: MyTextStyles.f16.copyWith(color: MyColors.black3),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(height: 30),
              Obx(
                () => ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ctr.pointMgmtList.length,
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20),
                  itemBuilder: (BuildContext context, int index) {
                    return PointListItem(ctr.pointMgmtList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
