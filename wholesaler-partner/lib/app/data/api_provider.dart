import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as mDio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/models/ad_history_model/ad_history_model.dart';
import 'package:wholesaler_partner/app/models/ad_order_model/ad_order_model.dart';
import 'package:wholesaler_partner/app/models/ad_product_model.dart';
import 'package:wholesaler_partner/app/models/best_products_model.dart';
import 'package:wholesaler_partner/app/models/product_modify_model/product_modify_model.dart';
import 'package:wholesaler_partner/app/models/register_ceo_employee/address.dart';
import 'package:wholesaler_partner/app/models/store_location_model.dart';
import 'package:wholesaler_partner/app/modules/ad/tab1_ad_status/models/ad_effectiveness_report_model.dart';
import 'package:wholesaler_partner/app/modules/ad/tab2_ad_application/model/ad_tab2_apply_model.dart';
import 'package:wholesaler_partner/app/modules/business_registration_submit/controllers/business_registration_submit_controller.dart';
import 'package:wholesaler_partner/app/modules/payment/models/order_history_model.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/controller/product_mgmt_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_2_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_3_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_4_controller.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/constants/functions.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/bulletin_model.dart';
import 'package:wholesaler_user/app/models/inquiry_model.dart';
import 'package:wholesaler_user/app/models/point_mgmt_page_model.dart';
import 'package:wholesaler_user/app/models/product_image_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../models/main_store_model.dart';
import '../models/order_response.dart';
import '../models/staff_model.dart';

class pApiProvider extends GetConnect {
  Map<String, String> headers = {
    "Authorization": "Bearer " + CacheProvider().getToken()
  };

  @override
  void onInit() {
    httpClient.timeout = const Duration(seconds: 60);
    super.onInit();
  }

  Future<bool> chekToken() async {

    Map<String, dynamic> body = {
      'access_token': CacheProvider().getToken()
    };

    String url = mConst.API_BASE_URL + mConst.API_STORE_PATH + '/login-check';
    final response = await post(url, body, headers: headers);
    log('putAddStoreFavorite $response');

    if (response.statusCode == 200) {
      log('response ${response.bodyString}');
      return true;
    } else {
      var jsonList = jsonDecode(response.bodyString!);
      log('error:' + jsonList.toString());
      //mSnackbar(message: '에러가 발생했습니다. ${response.bodyString!}');
      return false;
    }
  }

  // ###### COMMON APIs ######
  /// Common 휴대폰 인증 요청 API
  Future<int> postRequestVerifyPhoneNum({required String phoneNumber}) async {
    log(' getVerifyPhone -> phoneNumber $phoneNumber');

    String url = mConst.API_BASE_URL +
        mConst.API_COMMON_PATH +
        mConst.PHONE_NUM_VERIFY +
        phoneNumber;
    final response = await post(url, '');
    if (response.statusCode == 200) {
      mSnackbar(message: 'sent_verification_number'.tr);

      var json = jsonDecode(response.bodyString!);
      return json['certifi_id'];
    }
    if (response.statusCode == 400) {
      //mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// Common 휴대폰 인증 확인 API
  Future<bool> putPhoneNumVerify(
      {required String phoneNumber,
      required int certifi_id,
      required String phoneNumVerify}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_COMMON_PATH +
        mConst.PHONE_NUM_VERIFY +
        phoneNumber +
        '/check';

    Map<String, dynamic> body = {
      'auth_code': phoneNumVerify,
      'cerifi_id': certifi_id
    };

    final response = await put(url, body);
    if (response.statusCode == 200) {
      mSnackbar(message: 'phone_verification_finished'.tr);
      return true;
      // return json['certifi_id'];
    }
    if (response.statusCode == 400) {
     // mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: 'phone_verification_failed'.tr);
      return false;
    }
  }

  // ###### PARTNER APIs ######
  /// 회원가입 (대표/직원) -> 스토어 위치 정보 조회
  Future<List<Address>> getStoreLocations(
      {required BuildingType buildingType, int? parent_id}) async {
    print(
        'getStoreLocations -> buildingType $buildingType, parent_id $parent_id');
    Map<String, dynamic> query = {
      'type': buildingType.name,
      'parent_id': parent_id?.toString()
    };

    final response = await get(
        mConst.API_BASE_URL +
            mConst.API_STORE_PATH +
            mConst.Partner_STORE_LOCATION,
        query: query);
    print('getStoreLocations -> response.bodyString ${response.bodyString}');

    if (response.statusCode == 200) {
      print(
          '200 getStoreLocations -> response.bodyString ${response.bodyString}');
      List<Address> addresses = [];
      final rawList = jsonDecode(response.bodyString!);
      for (var item in rawList) {
        print('getStoreLocations -> item $item');
        final address = Address.fromJson(item);
        addresses.add(address);
      }
      return addresses;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// 회원가입 (대표/직원) -> ID 중복확인 API
  Future<bool> getVerifyId({required String userId}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        mConst.Partner_ID_VERIFY +
        userId;
    final response = await get(url);
    var json = jsonDecode(response.bodyString!);
    log(json.toString());
    if (response.statusCode == 200) {
      return json['is_reduplication'];
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// 사업자등록증 이미지 업로드 API
  Future<ProductImageModel> postUploadBusinessRegisterImage(
      {required XFile pickedImage}) async {
    var dio = mDio.Dio();
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        mConst.BUSINESS_REGISTER_IMG_UPLOAD;
    File image = File(pickedImage.path);
    String imageName = image.path.substring(image.path.length - 19);
    log('image name: $imageName');

    mDio.FormData formData = mDio.FormData.fromMap({
      "image":
          await mDio.MultipartFile.fromFile(image.path, filename: imageName),
    });
    final response = await dio.post(url, data: formData);
    print(
        ' postUploadBusinessRegisterImage -> response ${response.statusCode}');

    if (response.statusCode == 200) {
      var json = response.data;
      log(json['url']);

      return ProductImageModel(
          message: '업로드 완료되었습니다.',
          statusCode: 200,
          url: json['url'],
          path: json['file_path']);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.data!)['description']);
      return Future.error(response.statusMessage!);
    } else {
      mSnackbar(message: response.statusMessage!);
      return Future.error(response.statusMessage!);
    }
  }

  /// 회원가입 (대표/직원) -> ID 중복확인 API
  Future<bool> postStaffRegister() async {
    RegisterCeoEmployee2Controller p2Ctr =
        Get.put(RegisterCeoEmployee2Controller());
    RegisterCeoEmployee3Controller p3Ctr =
        Get.put(RegisterCeoEmployee3Controller());
    RegisterCeoEmployee4Controller p4Ctr =
        Get.put(RegisterCeoEmployee4Controller());
    // BusinessRegistrationSubmitController businessRegistrationSubmitCtr = Get.put(BusinessRegistrationSubmitController());

    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.STAFF_REGISTER;
    Map<String, dynamic> body = {
      'account_id': p3Ctr.idCtr.text,
      'password': p3Ctr.passwordCtr.text,
      'name': p3Ctr.ceoNameCtr.text,
      'phone': p4Ctr.phoneNumCtr.text,
      'certifi_id': p4Ctr.certifi_id,
      'store_id': p2Ctr.selectedUnit.value.store_id,
    };
    final response = await post(url, body);
    log(' postStaffRegister res');
    var json = jsonDecode(response.bodyString!);
    log("response : " + json.toString());
    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return false;
      // return Future.error(response.statusText!);
    }
  }

  Future<bool> postCeoRegister() async {
    RegisterCeoEmployee2Controller p2Ctr =
        Get.put(RegisterCeoEmployee2Controller());
    RegisterCeoEmployee3Controller p3Ctr =
        Get.put(RegisterCeoEmployee3Controller());
    RegisterCeoEmployee4Controller p4Ctr =
        Get.put(RegisterCeoEmployee4Controller());
    BusinessRegistrationSubmitController businessRegistrationSubmitCtr =
        Get.put(BusinessRegistrationSubmitController());

    print(
        ' businessRegistrationSubmitCtr.uploadedImageURL.value ${businessRegistrationSubmitCtr.uploadedImageURL.value}');

    // String imagePath = businessRegistrationSubmitCtr.uploadedImageURL.value.split("/").last;
    // print('imagePath $imagePath');

    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.CEO_REGISTER;
    Map<String, dynamic> body = {
      'account_id': p3Ctr.idCtr.text,
      'password': p3Ctr.passwordCtr.text,
      'business_name': p3Ctr.companyNameCtr.text,
      'business_regist_number': p3Ctr.BusinessRegisterNumCtr.text,
      'business_regist_image_file_path':
          businessRegistrationSubmitCtr.uploadedImagePath.value,
      'name': p3Ctr.ceoNameCtr.text,
      'building_id': p2Ctr.selectedBuilding.value.id,
      'floor_id': p2Ctr.selectedFloor.value.id,
      'unit_id': p2Ctr.selectedUnit.value.id,
      'phone': p4Ctr.phoneNumCtr.text,
      'certifi_id': p4Ctr.certifi_id,
    };
    final response = await post(url, body);
    log(' postCeoRegister res');
    var json = jsonDecode(response.bodyString!);
    log("response : " + json.toString());
    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return false;
      // return Future.error(response.statusText!);
    }
  }

  Future<StatusModel> getAccountId({required Map<String, dynamic> data}) async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.ACCOUNT_ID;

    final response = await get(url, query: data);
    var json = jsonDecode(response.bodyString!);
    String message = json['description'] ?? '';
    int statusCode = response.statusCode ?? 0;

    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = json['accountId'].toString();
        break;
      case 400:
        message = json['description'];
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<StatusModel> setStaffStatus(
      {required Map<String, dynamic> data, required String id}) async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/staff/$id/status';

    final response = await put(url, data, headers: headers);
    var json = jsonDecode(response.bodyString!);
    String message = '';
    int statusCode = response.statusCode ?? 0;

    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = '완료되었습니다.';
        break;
      case 400:
        message = json['description'];
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<StatusModel> deleteStaff({required String id}) async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/staff/$id/showing';

    final response = await delete(url, headers: headers);
    var json = jsonDecode(response.bodyString!);
    String message = '';
    int statusCode = response.statusCode ?? 0;

    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = '삭제되었습니다.';
        break;
      case 400:
        message = json['description'];
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<StatusModel> findPassword({required Map<String, dynamic> data}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        mConst.ACCOUNT_ID +
        mConst.CHECK;

    final response = await post(url, data);
    print(' findPassword response ${response.bodyString}');

    String message = '';
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = '완료되었습니다.';
        break;
      default:
        var json = jsonDecode(response.bodyString!);
        message = json['description'] ?? '';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<StatusModel> resetPassword(
      {required Map<String, dynamic> data}) async {
    String url = mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.PASSWORD;
    final response = await put(url, data);

    var json = jsonDecode(response.bodyString!);
    log(json.toString());

    String message = '';
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = '완료되었습니다.';
        break;
      default:
        message = json['description'] ?? '';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<dynamic> Partner_login(Map<String, dynamic> data) async {
    String url = mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.LOGIN;
    final response = await post(url, data);
    print(' Partner_login response ${response.bodyString}');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      headers={ "Authorization" : "Bearer " +json["access_token"]};
      return json;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return false;

      // return Future.error(response.statusText!);
    } else {
      mSnackbar(message: '로그인 실패');
      return false;
    }
  }

  Future<StatusModel> getAccountInfo() async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/me/account-info';
    final response = await get(url, headers: headers);
    String message = '';
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 0:
        message = 'error';
        break;
      case 200:
        message = '완료되었습니다.';
        break;
      default:
        var json = jsonDecode(response.bodyString!);
        message = json['description'] ?? '';
        break;
    }
    return StatusModel(
        statusCode: statusCode, message: message, data: response.bodyString);
  }

  Future<StatusModel> getOwnerInfo() async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/business-name';
    final response = await get(url, headers: headers);
    String message = '';
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 0:
        message = 'error';
        break;
      case 200:
        message = '완료되었습니다.';
        break;
      default:
        var json = jsonDecode(response.bodyString!);
        message = json['description'] ?? '';
        break;
    }
    return StatusModel(
        statusCode: statusCode, message: message, data: response.bodyString);
  }

  Future<StatusModel> saveAccountInfo(Map<String, dynamic> data) async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/me/account-info';
    final response = await put(url, data, headers: headers);
    int statusCode = response.statusCode ?? 0;
    String message = '';
    switch (statusCode) {
      case 200:
        message = '완료되었습니다';
        break;
      default:
        var json = jsonDecode(response.bodyString ?? '');
        message = json['description'] ?? 'error';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<StatusModel> saveCompanyName(Map<String, dynamic> data) async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/business-name';
    final response = await put(url, data, headers: headers);
    int statusCode = response.statusCode ?? 0;
    String message = '';
    switch (statusCode) {
      case 200:
        message = '완료되었습니다';
        break;
      default:
        var json = jsonDecode(response.bodyString ?? '');
        message = json['description'] ?? 'error';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }
  Future<StatusModel> saveLicense(Map<String, dynamic> data) async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/business-license-info';
    final response = await put(url, data, headers: headers);
    int statusCode = response.statusCode ?? 0;
    String message = '';
    switch (statusCode) {
      case 200:
        message = '완료되었습니다';
        break;
      default:
        var json = jsonDecode(response.bodyString ?? '');
        message = json['description'] ?? 'error';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<ProductImageModel?> uploadStoreImage(
      {required XFile pickedImage}) async {
    var dio = mDio.Dio();

    dio.options.headers["Authorization"] =
        "Bearer " + CacheProvider().getToken();

    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.STORE_IMAGE;
    File image = File(pickedImage.path);
    String imageName = image.path.substring(image.path.length - 19);
    log('image name: $imageName');

    mDio.FormData formData = mDio.FormData.fromMap({
      "image":
          await mDio.MultipartFile.fromFile(image.path, filename: imageName),
    });
    final response = await dio.post(
      url,
      data: formData,
    );
    print(
        ' postUploadBusinessRegisterImage -> response ${response.statusCode}');

    if (response.statusCode == 200) {
      var json = response.data;
      return ProductImageModel(
          message: '업로드 완료',
          statusCode: response.statusCode!,
          url: json['url'],
          path: json['file_path']);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.data!)['description']);
      return Future.error(response.statusMessage!);
    } else {
      mSnackbar(message: response.statusMessage!);
      return Future.error(response.statusMessage!);
    }
  }

  Future<String> uploadMainTopImage(
      {required Map<String, dynamic> data}) async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.MAIN_TOP_IMAGE;
    final response = await post(url, data, headers: headers);
    log('top image' + response.body.toString());
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      print(' json : ' + json.toString());
      return "https://image.thinksmk.com/images/advertisement/2022/07/22/PqTv8rNpBwHHTHd42V6qRIJl4BIJN4cXqjZZPhMt.png";
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<ProductImageModel> uploadProductImage(
      {required File pickedImage}) async {
    var dio = mDio.Dio();

    dio.options.headers["Authorization"] =
        "Bearer " + CacheProvider().getToken();
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.PRODUCT_IMAGE;
    File image = File(pickedImage.path);
    String imageName = image.path.substring(image.path.length - 19);
    log('image name: $imageName');

    mDio.FormData formData = mDio.FormData.fromMap({
      "image":
          await mDio.MultipartFile.fromFile(image.path, filename: imageName),
    });
    final response = await dio.post(
      url,
      data: formData,
    );
    print(
        ' postUploadBusinessRegisterImage -> response ${response.statusCode}');

    if (response.statusCode == 200) {
      var json = response.data;
      return ProductImageModel(
          message: '업로드 완료',
          statusCode: response.statusCode!,
          url: json['url'],
          path: json['file_path']);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.data!)['description']);
      return Future.error(response.statusMessage!);
    } else {
      mSnackbar(message: response.statusMessage!);
      return Future.error(response.statusMessage!);
    }
  }

  Future<StatusModel> uploadStoreThumbnailImage(
      {required Map<String, dynamic> data}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        mConst.STORE_THUMBNAIL_IMAGE;
    final response = await post(url, data, headers: headers);
    var json = jsonDecode(response.bodyString!);
    String message = json['description'] ?? '';
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 200:
        message = '업로드 완료!';
        break;
      default:
        var json = jsonDecode(response.bodyString ?? '');
        message = json['description'] ?? '오류';
        break;
    }
    return StatusModel(
        statusCode: statusCode, message: message, data: response.bodyString);
  }

  Future<List<BulletinModel>> getBulletins() async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.NOTICE_BOARDS,
        headers: headers);
    if (response.statusCode == 200) {
      Iterable raw = jsonDecode(response.bodyString!);
      List<BulletinModel> bulletins =
          raw.map((model) => BulletinModel.fromJson(model)).toList();
      return bulletins;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<List<StaffModel>> getStaffs() async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/staffs',
        headers: headers);
    if (response.statusCode == 200) {
      Iterable raw = jsonDecode(response.bodyString!);
      List<StaffModel> reviews =
          raw.map((model) => StaffModel.fromJson(model)).toList();
      return reviews;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> getStoreReviews() async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/store/reviews',
        headers: headers);
    if (response.statusCode == 200) {
      print(' getStoreReviews response.bodyString : ' +
          response.bodyString!);
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  // add offset and limit
  Future<OrderResponse> getOrders(
      {required String startDate,
      required String endDate,
      required int offset,
      required int limit}) async {
    Map<String, dynamic> data = {};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['offset'] = offset.toString();
    data['limit'] = limit.toString();
    headers={"Authorization": "Bearer " + CacheProvider().getToken()};
    String url = mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.ORDERS;
    final response = await get(url, query: data, headers: headers);
    if (response.statusCode == 200) {
      return OrderResponse.fromJson(jsonDecode(response.bodyString!));
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> getProducts({
    String? searchContent,
    String? startDate,
    String? endDate,
    List<int>? clothCatIds,
    String? sort,
    bool? isDingDong,
    required int offset,
    required int limit,
  }) async {
    headers={
      "Authorization": "Bearer " + CacheProvider().getToken()
    };
    Map<String, dynamic> data = {};

    data['offset'] = offset.toString();
    data['limit'] = limit.toString();

    // dingdong
    if (isDingDong != null && isDingDong == true) {
      data['type'] = 'privilege';
    }

    // sort: 최신순, 판매순
    if (sort != null) {
      if (sort == SortProductDropDownItem.latest) {
        data['sort'] = 'latest';
      } else if (sort == SortProductDropDownItem.bySales) {
        data['sort'] = 'sale';
      } else if (sort == SortProductDropDownItem.bySoldout) {
        data['sort'] = 'soldout';
      }
    }

    // convert clothCatIndexes Array -> 1,2,5 string
    String clothCatIdsStr = '';
    if (clothCatIds != null) {
      for (int i = 0; i < clothCatIds.length; i++) {
        String comma =
            i == 0 ? '' : ','; // don't create comma before first number
        clothCatIdsStr = (clothCatIdsStr + comma + clothCatIds[i].toString());
      }
      data['mainCategoryIdList'] = clothCatIdsStr;
    }

    if (searchContent != null) {
      data['searchContent'] = searchContent;
    }
    if (startDate != null && endDate != null) {
      data['startDate'] = startDate;
      data['endDate'] = endDate;
    }
    String url = mConst.API_BASE_URL + mConst.API_STORE_PATH + '/mine/products';

    final response = await get(url, headers: headers, query: data);
    log(CacheProvider().getToken());
    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  // 상품관리 Product mgmt page
  Future<StatusModel> deleteProduct() async {
    // find all checked products, add them to the list and send to server
    List<int> selectedProductIds = [];
    for (Product product in Get.put(ProductMgmtController()).products) {
      if (product.isChecked!.value) {
        selectedProductIds.add(product.id);
      }
    }
    log(' productIdList $selectedProductIds');

    String url = mConst.API_BASE_URL + mConst.API_STORE_PATH + '/mine/products';
    Map<String, dynamic> query = {"productIdList": selectedProductIds};

    var dio = mDio.Dio();
    dio.options.headers["authorization"] =
        "bearer ${CacheProvider().getToken()}";

    try {
      final response = await dio.delete(url, data: query);
      log(' delete resp ${response.data}');
      log(' no error.statusCode ${response.statusCode!} ');
      return StatusModel(
          statusCode: response.statusCode!, message: 'successfully deleted');
    } catch (e) {
      log(' delete error. e $e');
      return StatusModel(statusCode: 0, message: 'Error $e');
    }
  }

  Future<List<InquiryModel>> getStoreInquiries() async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/store/inquiries',
        headers: headers);
    print(' response ${response.bodyString}');

    if (response.statusCode == 200) {
      Iterable raw = jsonDecode(response.bodyString!);
      List<InquiryModel> inquiries =
          raw.map((model) => InquiryModel.fromJson(model)).toList();

      return inquiries;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<List<BestProductsModel>> getBestProducts() async {
    headers={
      "Authorization": "Bearer " + CacheProvider().getToken()
    };
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        mConst.STORE_BEST_PRODUCTS;
    final response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable raw = jsonDecode(response.bodyString!);
      List<BestProductsModel> bestProducts =
          raw.map((model) => BestProductsModel.fromJson(model)).toList();

      return bestProducts;
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<List<BestProductsModel>> getBestProductsRecommended() async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        mConst.STORE_BEST_PRODUCTS +
        '/recommended';
    final response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable raw = jsonDecode(response.bodyString!);
      List<BestProductsModel> bestProducts =
          raw.map((model) => BestProductsModel.fromJson(model)).toList();

      return bestProducts;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> getAdsMainPage() async {
    headers={
      "Authorization": "Bearer " + CacheProvider().getToken()
    };
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.ADVERTISEMENT_LIST;
    final response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  // Top10 Products page
  Future<StatusModel> setBestProductsTop10Page(
      {required Map<String, dynamic> data}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        mConst.STORE_BEST_PRODUCTS;
    final response = await post(url, data, headers: headers);
    String message = '';
    if (response.bodyString.toString() != '[]') {
      var json = jsonDecode(response.bodyString.toString());
      message = json['description'] ?? '';
    }
    // log(response.statusCode.toString());
    // log(json.toString());
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = '저장되었습니다.';
        break;
      case 400:
        message = message;
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  // Product Management Page
  // Future<StatusModel> addBestProductsProductMgmtPage() async {

  // }

  Future<List<InquiryModel>> getQuestions({required String id}) async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/product/$id/inquiries',
        headers: headers);
    if (response.statusCode == 200) {
      Iterable raw = jsonDecode(response.bodyString!);
      List<InquiryModel> questions =
          raw.map((model) => InquiryModel.fromJson(model)).toList();

      return questions;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// Partner Main page > getMainStore
  Future<MainStoreModel> getMainStore() async {

    headers={
      "Authorization": "Bearer " + CacheProvider().getToken()
    };
    print("======getMainStore${headers}============");
    final response = await get(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/main',
        headers: headers);
    if (response.statusCode == 200) {
      return MainStoreModel.fromJson(response.body);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<Response> getUserInfo() async {
    headers={
      "Authorization": "Bearer " + CacheProvider().getToken()
    };
    String url = mConst.API_BASE_URL + mConst.API_STORE_PATH + '/me';
    final response = await get(url, headers: headers);
    return response;
  }

  Future<bool> addProduct({required Map<String, dynamic> data}) async {
    final response = await post(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + mConst.PRODUCT, data,
        headers: headers);
    log(response.body.toString());

    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: '오류: ${response.bodyString}');
      return false;
    }
  }

  editProduct(
      {required Map<String, dynamic> data, required int productId}) async {
    final response = await put(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/product/$productId',
        data,
        headers: headers);
    print(' editProduct response ${response.body}');

    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: '오류: ${response.bodyString}');
      return false;
    }
  }

  Future<StatusModel> soldOut({
    required Map<String, dynamic> data,
  }) async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/mine/products/sold-out';

    final response = await put(url, data, headers: headers);
    var json = jsonDecode(response.bodyString!);

    String message = '';
    int statusCode = response.statusCode ?? 0;

    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = '처리 되었습니다.';
        break;
      case 400:
        message = json['description'] ?? '';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<StatusModel> addToDingDong({
    required Map<String, dynamic> data,
  }) async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        '/mine/products/privilege';

    final response = await put(url, data, headers: headers);

    String message = '';
    int statusCode = response.statusCode ?? 0;

    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = '처리 되었습니다.';
        break;
      default:
        var json = jsonDecode(response.bodyString ?? '');
        message = json['description'] ?? 'error';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<StatusModel> addToTop10({
    required Map<String, dynamic> data,
  }) async {
    print(' addToTop10 data ${data}');
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/mine/product/bests';

    final response = await post(url, data, headers: headers);

    String message = '';
    int statusCode = response.statusCode ?? 0;

    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = '처리 되었습니다.';
        break;
      default:
        var json = jsonDecode(response.bodyString ?? '');
        message = json['description'] ?? 'error';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<StatusModel> removeTop10(
      {required Map<String, List<int>> data}) async {
    print(' removeTop10 data ${data}');
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/mine/product/bests';

    final response = await put(url, data, headers: headers);

    String message = '';
    int statusCode = response.statusCode ?? 0;

    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = '삭제 되었습니다.';
        break;
      default:
        var json = jsonDecode(response.bodyString ?? '');
        message = json['description'] ?? 'error';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  Future<bool> addToAd(
      {required Map<String, dynamic> data,
      required int adApplicationId}) async {
    print(' addToAd data ${data} adApplicationId ${adApplicationId}');
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        '/advertisement/application/$adApplicationId/products';
    final response = await post(url, data, headers: headers);
    print(' addToAd response ${response.body}');

    var json = jsonDecode(response.bodyString!);

    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: '오류: ${response.bodyString}');
      return false;
    }
  }

  Future<dynamic> getSaleProducts(String type) async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        '/wholesale-report?type=$type';
    final response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> editUserInformation({
    required Map<String, dynamic> data,
  }) async {
    String url = mConst.API_BASE_URL + mConst.API_STORE_PATH + '/staff/me';
    print(' editUserInformation data ${data}');

    final response = await put(url, data, headers: headers);
    print(' editUserInformation response ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    } else {
      print('${response.body} ');
      if (response.statusCode == 400) {
        mSnackbar(message: '인증번호를 다시 확인해주세요.');
      } else {
        mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      }
      return null;
    }
  }

  Future<dynamic> getBusinessLicense() async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/business-license-info',
        headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> getPayments(String year, String month) async {
    final response = await get(
        mConst.API_BASE_URL +
            mConst.API_STORE_PATH +
            '/settlement-mgmt?year=$year&month=$month',
        headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> getPaymentOrders(String date) async {
    final response = await get(
        mConst.API_BASE_URL +
            mConst.API_STORE_PATH +
            '/settlement-mgmt/sale-details?date=$date',
        headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> getPoint() async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/me',
        headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<AdEffectiveReportModel> getAdEffectiveReport(
      String startDate, String endDate) async {
    final response = await get(
        mConst.API_BASE_URL +
            mConst.API_STORE_PATH +
            '/advertisement/effect-report?startDate=$startDate&endDate=$endDate',
        headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      AdEffectiveReportModel adEffectiveReportModel = AdEffectiveReportModel(
        store_visit_count: json['store_visit_count'].toString(),
        order_total_amount:
            Utils.numberFormat(number: json['order_total_amount']),
        privilge_order_total_amount:
            Utils.numberFormat(number: json['privilge_order_total_amount']),
      );

      return adEffectiveReportModel;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<List<ExposureAdModel>> getAdExposureProducts(
      {required int ads_type_code}) async {
    Map<String, dynamic> data = {};
    data['ads_type_code'] = ads_type_code.toString();

    final response = await get(
        mConst.API_BASE_URL +
            mConst.API_STORE_PATH +
            '/advertisement/exposure-advertisements',
        headers: headers,
        query: data);
    if (response.statusCode == 200) {
      List<ExposureAdModel> advertisements = [];

      var json = jsonDecode(response.bodyString!);
      for (var i = 0; i < json.length; i++) {
        var productList = json[i]['ads_application_products'];
        List<Product> tempProductList = [];

        // decode ad product list
        for (var j = 0; j < productList.length; j++) {
          tempProductList.add(Product(
              imgHeight: 145,
              imgWidth: 116,
              id: productList[j]['id'],
              price: productList[j]['price'],
              title: productList[j]['product_name'],
              imgUrl: productList[j]['thumbnail_image_url'],
              store: Store(id: productList[j]['store_id'])));
        }

        ExposureAdModel ad = ExposureAdModel(
            date: json[i]['ads_application_date'],
            adProducts: tempProductList,
            ads_application_id: json[i]['ads_application_id']);
        advertisements.add(ad);
      }
      return advertisements;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      print('getAdExposureProducts  error: response.statusText!');
      mSnackbar(message: response.statusText!);
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> getImpressionsInformation(
      String startDate, String endDate, String tag) async {
    print(
        'getImpressionsInformation startDate: $startDate endDate: $endDate');
    // '광고R', '광고S', '광고1ST', '광고2ST', '광고3ST'
    int addNumber = -1;
    if (tag == '광고R') {
      addNumber = 100;
    } else if (tag == '광고S') {
      addNumber = 200;
    } else if (tag == '광고1ST') {
      addNumber = 300;
    } else if (tag == '광고2ST') {
      addNumber = 400;
    } else if (tag == '광고3ST') {
      addNumber = 500;
    } else if (tag == '광고4ST') {
      addNumber = 600;
    }

    final response = await get(
        mConst.API_BASE_URL +
            mConst.API_STORE_PATH +
            '/advertisement/$addNumber/statistic?startDate=$endDate&endDate=$startDate',
        headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<HistoryAdModel> getApplicationHistory() async {
    final response = await get(
        mConst.API_BASE_URL +
            mConst.API_STORE_PATH +
            '/advertisement/application-history',
        headers: headers);
    print('getApplicationHistory response: ${response.bodyString}');

    if (response.statusCode == 200) {
      return HistoryAdModel.fromJson(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> getProductDetails(int productId) async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/product/$productId',
        headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      print('getProductDetails error');
      mSnackbar(message: response.statusText!);
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> getExhibitDetails(String imageId) async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/exhibitions/$imageId',
        headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      print('why not working ${jsonDecode(response.bodyString!)}');
      return Future.error(response.statusText!);
    }
  }

  // Future<StatusModel> submitInquiry({required String id, required Map<String, dynamic> data}) async {
  //   String url = mConst.API_BASE_URL + mConst.API_STORE_PATH + '/products/$id/inquiry';

  //   final response = await post(url, data, headers: headers);

  //   var json = jsonDecode(response.bodyString!);

  //   String message = '';
  //   int statusCode = response.statusCode ?? 0;

  //   switch (statusCode) {
  //     case 0:
  //       message = 'Has Error';
  //       break;
  //     case 200:
  //       message = '완료 되었습니다.';
  //       break;
  //     case 400:
  //       message = json['description'];
  //       break;
  //   }
  //   return StatusModel(statusCode: statusCode, message: message);
  // }

  Future<List<StoreLocation>> getSearchStoreName(String searchValue) async {
    final response = await get(mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        '/search/store-location?store_name=$searchValue');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      print('getSearchStoreName :' +
          jsonDecode(response.bodyString!).toString());
      List<StoreLocation> storeLocations = [];
      for (var storeLocation in json) {
        StoreLocation tempStoreLocation = StoreLocation.fromJson(storeLocation);
        storeLocations.add(tempStoreLocation);
      }
      return storeLocations;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      print('getProductDetails error');
      mSnackbar(message: response.statusText!);
      return Future.error(response.statusText!);
    }
  }

  Future<List<OrderHistoryExpandedModel>> getPaymentTab2_OrderHistory(
      String date) async {
    final response = await get(
        mConst.API_BASE_URL +
            mConst.API_STORE_PATH +
            '/settlement-mgmt/sale-details?date=$date',
        headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      print('getPaymentTab2_OrderHistory :' +
          jsonDecode(response.bodyString!).toString());
      List<OrderHistoryExpandedModel> orderHistories = [];
      for (var historyJson in json) {
        OrderHistoryExpandedModel tempOrderHistory =
            OrderHistoryExpandedModel.fromJson(historyJson);
        orderHistories.add(tempOrderHistory);
      }
      return orderHistories;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      print('getProductDetails error');
      mSnackbar(message: response.statusText!);
      return Future.error(response.statusText!);
    }
  }

  /// Ad > Tab 2: Ad Apply > Inquiry
  Future<AdTab2ApplyModel?> getAdTab2AdApplyInquiry(int adsId) async {
    final response = await get(
        '${mConst.API_BASE_URL}${mConst.API_STORE_PATH}/advertisement/application-info?ads_application_id=$adsId',
        headers: headers);

    print('getAdTab2AdApplyInquiry :' + response.bodyString!);

    if (response.statusCode == 200) {
      return AdTab2ApplyModel.fromJson(response.bodyString!);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      print('getAdTab2AdApplyInquiry error: ${response.statusText}');
      // mSnackbar(message: response.statusText!);
      return null;
    }
  }

  /// Ad > Tab 2: Ad Apply > Ad application
  Future<bool> postAdTab2AdApplication(
      {required int adApplicationId,
      required List<DateTime> applicationDates}) async {
    log('postAdTab2AdApplication -> applicationDates $applicationDates');

    List<String> datesStr = [];
    for (var date in applicationDates) {
      String tempDate = Utils.dateToString(date: date);
      datesStr.add(tempDate);
    }

    Map<String, dynamic> body = {
      'application_date_list': datesStr,
    };

    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        '/advertisement/$adApplicationId/applications';

    final response = await post(url, body, headers: headers);

    if (response.statusCode == 200) {
      print('postAdTab2AdApplication : ${response.bodyString!}');
      mSnackbar(message: '신청이 완료 되었습니다.');
      return true;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: response.bodyString!);
      return Future.error(response.statusText!);
    }
  }

  // point mgmt
  Future<List<PointMgmtPageModel>> getPointMgmtListForPartner() async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/store/point-history';

    final response = await get(url, headers: headers);
    print('getPointMgmtListForPartner ${response.bodyString}');

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<PointMgmtPageModel> pointMgmt = [];
      for (var json in jsonList) {
        pointMgmt.add(PointMgmtPageModel.fromJson(json));
      }
      return pointMgmt;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  // 광고신청내역 >
  Future<bool> chargePoint({required int point, required String name}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        '/point/deposit-application';
    Map<String, dynamic> body = {
      'point': point,
      'depositor_name': name,
    };
    dynamic response = await post(url, body, headers: headers);
    print('chargePoint ${response.bodyString}');

    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: response.bodyString!);
      return Future.error(response.statusText!);
    }
  }

  Future<AdOrderModel> getAdOrder({required String advertisementId}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        '/advertisement/$advertisementId';
    dynamic response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      return AdOrderModel.fromJson(json);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: response.bodyString!);
      return Future.error(response.statusText!);
    }
  }

  Future<List<BulletinModel>> getPartnerBulletins() async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/notice-boards',
        headers: headers);
    print('getPartnerBulletins ${response.bodyString}');
    if (response.statusCode == 200) {
      Iterable raw = jsonDecode(response.bodyString!);
      List<BulletinModel> bulletins =
          raw.map((model) => BulletinModel.fromJson(model)).toList();

      return bulletins;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<ProductModifyModel> getProductEditInfo({required productId}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        '/product/$productId/for-modify';

    var response = await get(url, headers: headers);
    print('getProductEditInfo ${response.bodyString}');

    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      return ProductModifyModel.fromJson(json);
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: response.bodyString!);
      return Future.error(response.statusText!);
    }
  }

  Future<bool> deleteAdProduct(int adId, productId) async {
    String url = mConst.API_BASE_URL +
        mConst.API_STORE_PATH +
        '/advertisement/$adId/product/$productId';
    dynamic response = await delete(url, headers: headers);
    print('deleteAdProduct ${response.bodyString}');

    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: response.bodyString!);
      return Future.error(response.statusText!);
    }
  }

  adPayment(int advertisement_application_id) async {
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/advertisement/payment';
    Map<String, dynamic> body = {
      'advertisement_application_id': advertisement_application_id
    };

    final response = await put(url, body, headers: headers);

    print('adPayment ${response.bodyString}');

    if (response.statusCode == 200) {
      mSnackbar(message: '결제가 완료 되었습니다.');
      return true;
    }
    print(response.bodyString);
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: response.bodyString!);
      return false;
    }
  }

  Future<bool> putAdBudget(
      int advertisement_application_id, int amountInt) async {
    print(
        'putAdBudget advertisement_application_id $advertisement_application_id amountInt $amountInt');
    String url =
        mConst.API_BASE_URL + mConst.API_STORE_PATH + '/advertisement/budget';

    Map<String, dynamic> body = {
      'advertisement_application_id': advertisement_application_id,
      'amount': amountInt,
    };

    final response = await put(url, body, headers: headers);

    print('putAdBudget ${response.bodyString}');

    if (response.statusCode == 200) {
      mSnackbar(message: '예산설정 완료되었습니다.');
      return true;
    }
    if (response.statusCode == 400) {
      mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      return Future.error(response.statusText!);
    } else {
      mSnackbar(message: response.bodyString!);
      return false;
    }
  }

  void withdrawAccount() {
    String url = mConst.API_BASE_URL + mConst.API_STORE_PATH + '/me';
    delete(url, headers: headers).then((response) {
      print('withdrawAccount ${response.bodyString}');
      if (response.statusCode == 200) {
        mSnackbar(message: '탈퇴 요청 완료되었습니다.');
        mFuctions.userLogout();
        return;
      }
      if (response.statusCode == 400) {
        mSnackbar(message: jsonDecode(response.bodyString!)['description']);
      } else {
        mSnackbar(message: '오류 ' + response.bodyString!);
      }
    });
  }
}
