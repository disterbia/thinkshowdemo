import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';

class ClothWash {
  ClothCareGuideId id;
  String iconPath;
  String title;
  RxBool isActive;

  ClothWash({
    required this.iconPath,
    required this.title,
    required this.isActive,
    required this.id,
  });
}
