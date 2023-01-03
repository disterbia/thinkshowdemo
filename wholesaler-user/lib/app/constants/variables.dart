import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wholesaler_user/app/constants/constants.dart';

class MyVars {
  /// Many classes are used on both user and partner projects.
  /// We use [MyVars] to customize these classes for each project.
  static bool isUserProject() {
    final box = GetStorage();
    return box.read("isUserProject") ?? true;
  }

  static setIsUserProject(bool isUserProject) {
    final box = GetStorage();
    box.write("isUserProject", isUserProject);
  }

  static bool isSmallPhone() {
    return Get.context!.width <= mConst.SmallPhoneWidth;
  }

  static Future<void> initializeVariables() async {
    // 1. initialize isUserProject
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    //print('packageName $packageName');
    if (packageName == 'com.thinksmk.user') {
      MyVars.setIsUserProject(true);
    } else if (packageName == 'com.thinksmk.partner_new' ||
        packageName == 'com.thinksmk.partner') {
      MyVars.setIsUserProject(false);
    } else {
      //print(
     //     'ERROR: isUserProject -> wholesaler partner or wholesaler user project name is changed. You should update isUserProject file');
    }
  }
}
