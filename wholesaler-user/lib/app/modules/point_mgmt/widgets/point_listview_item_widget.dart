import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/point_mgmt_page_model.dart';
import 'package:wholesaler_user/app/utils/utils.dart';

class PointListItem extends StatelessWidget {
  PointMgmtPageModel point;
  PointListItem(this.point);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grey8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  point.content!,
                  style: MyTextStyles.f14.copyWith(color: MyColors.black3),
                ),
                SizedBox(height: 5),
                Text(
                  point.createdAt!,
                  style: MyTextStyles.f12.copyWith(color: MyColors.grey2),
                ),
              ],
            ),
            Spacer(),
            Text(
              Utils.numberFormat(number: point.point!),
              style: MyTextStyles.f16.copyWith(color: MyColors.black2),
            ),
          ],
        ),
      ),
    );
  }
}
