import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wholesaler_user/app/modules/splash_screen/controller/splash_screen_controller.dart';

class SplashScreenPageView extends StatelessWidget {
  SplashScreenPageView();

  @override
  Widget build(BuildContext context) {
    SplashScreenController ctr = Get.put(SplashScreenController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/shared_images_icons/login_logo.png',
              width: 120,
            ),
            SizedBox(height: 20),
            Text('잠시만 기다려주세요...'),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
