import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../data/api_provider.dart';

class BottomNavbarController extends GetxController {
  final tabIndex = 0.obs;

  void updateNavBar(selectedIndex) => {tabIndex.value = selectedIndex};

}
