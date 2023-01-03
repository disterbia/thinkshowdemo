import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/firebase_options.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';

class FirebaseService {
  static init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    final fcmToken = await firebaseMessaging.getToken();
    print('fcmToken ${fcmToken}');
    if (fcmToken != null) {
      CacheProvider().setFCMToken(fcmToken);
      sendFCMTokenToServer(fcmToken);
    } else {
      log('fcmToken is null');
    }

    // token listener
    firebaseMessaging.onTokenRefresh.listen((fcmToken) {
      print('onTokenRefresh updated $fcmToken');
      CacheProvider().setFCMToken(fcmToken);
      // send fcmToken to server
      sendFCMTokenToServer(fcmToken);
    }).onError((err) {
      print('onTokenRefresh error $err');
    });

    iOSRequestPermission(Get.context, firebaseMessaging);

    setUpForegroundNotification(firebaseMessaging);
  }

  static Future<void> setUpForegroundNotification(FirebaseMessaging firebaseMessaging) async {
    // foreground notification for iOS
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static Future<void> sendFCMTokenToServer(String fcmToken) async {
    uApiProvider apiProvider = uApiProvider();
    await apiProvider.sendTCMToken(fcmToken);
  }
}

Future iOSRequestPermission(context, FirebaseMessaging firebaseMessaging) async {

    firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

}
