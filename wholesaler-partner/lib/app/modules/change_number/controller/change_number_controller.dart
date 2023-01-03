import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class ChangeNumberController extends GetxController {
  PhoneNumberPhoneVerifyController phoneNumberPhoneVerifyController = Get.put(PhoneNumberPhoneVerifyController());
  pApiProvider partnerApiProvider = pApiProvider();
  uApiProvider userApiProvider = uApiProvider();

  editBtnPressed() async {
    // check if phone number is empty
    if (phoneNumberPhoneVerifyController.numberController.text.isEmpty) {
      mSnackbar(message: '휴대폰 번호를 입력하세요.');
      return;
    }

    // check if only number
    if (!phoneNumberPhoneVerifyController.numberController.text.contains(RegExp(r'^[0-9]*$'))) {
      mSnackbar(message: '휴대폰 번호는 숫자만 입력하세요.');
      return;
    }

    // check verify code is empty
    if (phoneNumberPhoneVerifyController.numberVerifyController.text.isEmpty) {
      mSnackbar(message: '인증번호를 입력하세요.');
      return;
    }

    Map<String, dynamic> data;
    data = {
      'phone': phoneNumberPhoneVerifyController.numberController.text,
      'certifi_id': phoneNumberPhoneVerifyController.certifyId,
    };
    dynamic response;
    if (MyVars.isUserProject()) {
      print('data : ${data.toString()}');
      response = await userApiProvider.changePhoneNumber(data: data);
      Get.back();
    } else {
      response = await partnerApiProvider.editUserInformation(data: data);
    }

    // access_token
    if (!MyVars.isUserProject() && response != null && response['access_token'] != null) {
      CacheProvider().setToken(response['access_token']);
      mSnackbar(message: '휴대폰 번호가 변경되었습니다.');
      Get.back();
    }
  }
}
