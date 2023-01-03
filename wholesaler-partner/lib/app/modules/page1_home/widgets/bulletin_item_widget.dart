import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/models/bulletin_model.dart';
import 'package:wholesaler_partner/app/modules/ad_order/views/ad_order_view.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/utils/utils.dart';

class AdvertisementItemVertical extends StatelessWidget {
  Bulletin advertisement;
  AdvertisementItemVertical({
    required this.advertisement,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => advertisement.type == BulletinType.bulletin ? Get.to(() => null) : Get.to(() => AdOrderView(), arguments: advertisement.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 145,
            width: 116,
            child: CachedNetworkImage(
              imageUrl: advertisement.imgURL,
              width: Get.width,
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            // child: Image.asset(advertisement.imgURL),
          ),
          Text(
            advertisement.title,
            style: MyTextStyles.f14.copyWith(color: MyColors.black1),
          ),
          SizedBox(height: 8),
          Text(
            Utils.numberFormat(number: advertisement.cost, suffix: '원'),
            style: MyTextStyles.f16.copyWith(color: MyColors.black2),
          ),
        ],
      ),
    );
  }
}
