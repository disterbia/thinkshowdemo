import 'dart:math';
import 'package:get/get.dart';

import 'package:wholesaler_partner/app/constant/enums.dart';

class Bulletin {
  String id;
  String imgURL;
  String title;
  String subtitle = 'its_ad'.tr;
  BulletinType type;
  int cost;

  Bulletin({
    required this.id,
    required this.type,
    required this.title,
    required this.imgURL,
    required this.cost,
  });

  // static dummy() {
  //   List<Bulletin> bulletins = [
  //     Bulletin(
  //       id: 'nameit34',
  //       type: BulletinType.ad,
  //       title: 'ad'.tr,
  //       imgURL: 'assets/images/img_advertisement.png',
  //     ),
  //     Bulletin(
  //       id: 'id543',
  //       type: BulletinType.ad,
  //       title: 'ad'.tr,
  //       imgURL: 'assets/images/img_advertisement.png',
  //     ),
  //   ];
  //   return bulletins[Random().nextInt(bulletins.length)];
  // }
}
