import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/modules/main/view/partner_main_view.dart';
import 'package:wholesaler_partner/app/modules/page3_my_page/controllers/page3_my_page_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/views/register_ceo_employee_1_view.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/data/firebase_service.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_sign_up/views/user_sign_up_view.dart';
import 'package:wholesaler_user/app/modules/main/view/user_main_view.dart';

import '../../../../constants/variables.dart';
import '../../../../widgets/snackbar.dart';

class User_LoginPageController extends GetxController {
  pApiProvider Partner_apiProvider = pApiProvider();
  uApiProvider User_apiProvider = uApiProvider();
  // static bool isPrivilage = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  RxBool isLoading = false.obs;

  RxString appVersion = ''.obs;
  RxString appBuild = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    if (kDebugMode) {
      if (MyVars.isUserProject()) {
        // usernameController.text = "6666";
        // passwordController.text = "6666";
        // usernameController.text = "chlrkdxkr";
        // passwordController.text = "12341234";
      } else {
        // usernameController.text = "storetest4";
        // passwordController.text = "12345678";
        // usernameController.text = "ow3";
        // passwordController.text = "12341234";
        // usernameController.text = "1111";
        // passwordController.text = "2222";
        // usernameController.text = "chlove328";
        // passwordController.text = "dowkwmf1";
      }
    }

    // app version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
    appBuild.value = packageInfo.buildNumber;
  }

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    print("dddddddd");
    super.dispose();
  }

  Future<void> loginBtnPressed() async {
    if (usernameController.text.isEmpty) {
      mSnackbar(message: '아이디를 입력해주세요.'.tr);
      return;
    }
    if (passwordController.text.isEmpty) {
      mSnackbar(message: '비밀번호를 입력해주세요.'.tr);
      return;
    }

    isLoading(true);

    bool isSuccess = MyVars.isUserProject()
        ? await userLoginProcess()
        : await partnerLoginProcess();

    // initialize firebase
    if (isSuccess) {
      print('before initialize firebase');
      await FirebaseService.init();
    }
  }

  void signUpBtnPressed() {
    MyVars.isUserProject()
        ? Get.to(() => User_SignUpView())
        : Get.to(() => RegisterCeoEmployeePage1View());
  }

  // USER Login Process
  Future<bool> userLoginProcess() async {
    log('inside userLoginProcess');
    var response = await User_apiProvider.postLogin_User({
      "account_id": usernameController.text,
      "password": passwordController.text,
    });
    isLoading(false);
    print(usernameController.text);
    print(passwordController.text);
    if (response.statusCode == 200) {
      Get.to(() => UserMainView());
      return true;
    } else {
      mSnackbar(message: response.message);
      return false;
    }
  }

  // PARTNER Login Process
  Future<bool> partnerLoginProcess() async {
    log('inside partnerLoginProcess');
    dynamic response = await Partner_apiProvider.Partner_login({
      "account_id": usernameController.text,
      "password": passwordController.text,
    });
    print("asdfasdf : ${response}");
    isLoading(false);
    if (response == false) {
      return false;
    }
    dynamic status = response["status"];

    if (status.toString() == "normal") {
      String token = response["access_token"];
      CacheProvider().setToken(token);
      print("===============setToken${CacheProvider().getToken()}====================");
      // isPrivilage = response['is_privilege'];
      bool isOwner = response["is_owner"];
      // bool isPrivilege = response["is_privilege"];
      CacheProvider().setOwner(isOwner);
      CacheProvider().setPrivilege(response['is_privilege']);
      CacheProvider().setUserID(usernameController.text);
      Get.off(() => PartnerMainView());
      return true;
    } else if (status.toString() == "wait") {
      mSnackbar(message: '아직 승인이 되지 않았습니다.');
      return false;
    } else if (status.toString() == "denied") {
      mSnackbar(message: '가입요청이 거부된 회원입니다.');
      return false;
    } else {
      String description = response["description"];
      mSnackbar(message: description);
      return false;
    }
  }
}
