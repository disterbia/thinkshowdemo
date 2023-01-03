import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_partner/app/Constant/languages.dart';
import 'package:wholesaler_partner/firebase_options.dart';
import 'package:wholesaler_user/app/data/firebase_service.dart';
import 'package:wholesaler_user/app/data/notification_service.dart';
import 'package:wholesaler_partner/app/modules/ad/views/ad_view.dart';
import 'package:wholesaler_user/app/constants/theme.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/splash_screen/view/splash_screen_view.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await MyVars.initializeVariables();
  //bool isLogin = CacheProvider().getToken().isNotEmpty;
  //print('CacheProvider().getToken() ${CacheProvider().getToken()}');

  NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    GetMaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ko', 'KR'),
        ],
        translations: pLanguages(),
        locale: const Locale('ko', 'KR'),
        fallbackLocale: const Locale('ko', 'KR'),
        theme: appThemeDataLight,
        debugShowCheckedModeBanner: false,
        title: "Wholesale Partner App",
        home: SplashScreenPageView(),
        // getPages: [
        //   GetPage(name: '/login', page: () => User_LoginPageView()),
        // ]
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.to(() => AdView(), arguments: 2);
    });
    return Container();
  }
}
