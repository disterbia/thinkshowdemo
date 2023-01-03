import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_user/app/constants/languages.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/data/firebase_service.dart';
import 'package:wholesaler_user/app/data/notification_service.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/main/view/user_main_view.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/company_intro_page/view/company_intro_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/Product_detail_view.dart';
import 'package:wholesaler_user/app/modules/splash_screen/view/splash_screen_view.dart';
import 'package:wholesaler_user/firebase_options.dart';
import 'app/constants/theme.dart';
import 'app/data/cache_provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await GetStorage.init();
  //await MyVars.initializeVariables();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //print("Handling a background message: ${message.messageId}");
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  await MyVars.initializeVariables();

  NotificationService().init();


  runApp(
    GetMaterialApp(
      translations: uLanguages(),
      locale: const Locale('ko', 'KR'),
      fallbackLocale: const Locale('ko', 'KR'),
      theme: appThemeDataLight,
      debugShowCheckedModeBanner: false,
      title: "Wholesale User App",
      // home: UserMainView(),
      home: SplashScreenPageView(),

    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get.to(() => ProductDetailView(), arguments: 9659);
      // Get.to(() => StoreDetailView(storeId: 10));
      // Get.to(() => ProductCategoryPageView(0));
      // Get.to(() => ExhibitionProductsView(), arguments: {'imageId': 1});

      // Get.to(() => OrderInquiryAndReviewView(hasHomeButton: false, isBackEnable: true), arguments: false);
    });
    return Container();
  }
}
