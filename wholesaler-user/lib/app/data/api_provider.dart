import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/main_store_model.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/models/address_model.dart';
import 'package:wholesaler_user/app/models/bulletin_model.dart';
import 'package:wholesaler_user/app/models/cart1_orders_model/cart1_orders_model.dart';
import 'package:wholesaler_user/app/models/cart_model.dart';
import 'package:wholesaler_user/app/models/checkout_model/checkout_model.dart';
import 'package:wholesaler_user/app/models/faq_page_model/faq_page_model.dart';
import 'package:wholesaler_user/app/models/inquiries_model.dart';
import 'package:wholesaler_user/app/models/inquiry_model.dart';
import 'package:wholesaler_user/app/models/order_model.dart';
import 'package:wholesaler_user/app/models/point_mgmt_page_model.dart';
import 'package:wholesaler_user/app/models/product_cloth_caring_guide.dart';
import 'package:wholesaler_user/app/models/product_cloth_detail_spec.dart';
import 'package:wholesaler_user/app/models/product_image_model.dart';
import 'package:wholesaler_user/app/models/product_materials.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/product_model_info.dart';
import 'package:wholesaler_user/app/models/product_option_model.dart';
import 'package:wholesaler_user/app/models/product_sizes_model.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/models/search_product_auto_model.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/models/search_store_auto_model.dart';
import 'package:wholesaler_user/app/models/user_model.dart';
import 'package:wholesaler_user/app/models/writable_review_info_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_sign_up/controllers/user_sign_up_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/models/image_banner_model.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';

class uApiProvider extends GetConnect {
  Map<String, String> headers = {
    "Authorization": "Bearer " + CacheProvider().getToken()
  };

  @override
  void onInit() {
    super.onInit();
    httpClient.timeout = const Duration(seconds: 60);
  }

  // 비밀번호 찾기 API ( 비밀번호 변경 )
  Future<StatusModel> resetPassword(
      {required Map<String, dynamic> data}) async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + mConst.PASSWORD;
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
        message = '완료 되었습니다.';
        break;
      default:
        message = json['description'] ?? '';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  // 비밀번호 찾기 API ( 계정 확인 )
  Future<StatusModel> findPassword({required Map<String, dynamic> data}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        mConst.ACCOUNT_ID +
        mConst.CHECK;

    final response = await post(url, data);

    String message = '';
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        message = '완료 되었습니다.';
        break;
      default:
        var json = jsonDecode(response.bodyString!);
        message = json['description'] ?? '';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  // 아이디 찾기 API
  Future<StatusModel> getAccountId({required Map<String, dynamic> data}) async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + mConst.ACCOUNT_ID;

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
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  // ###### USER APIs ######
  /// Register New User page -> ID 중복체크 - Verify availability of ID
  Future<bool> getCheckIdAvailablity({required String userId}) async {
    final response = await get(mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/account-id/reduplication/' +
        userId);
    if (response.statusCode == 200) {
      final raw = jsonDecode(response.bodyString!);
      return !raw['is_reduplication'];
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// User sign up page
  Future<bool> postUserSignUp() async {
    log('inside postUserSignUp');
    SignupOrEditController signUpCtr = Get.put(SignupOrEditController());
    PhoneNumberPhoneVerifyController phoneCtr =
        Get.put(PhoneNumberPhoneVerifyController());

    log('signUpCtr.passwordController.text:' +
        signUpCtr.passwordController.text);
    log('signUpCtr.nameController.text ' + signUpCtr.nameController.text);
    log('signUpCtr.address1Controller.text ' +
        signUpCtr.address1Controller.text);
    log('signUpCtr.idController.text ' + signUpCtr.idController.text);
    Map<String, dynamic> body = {
      'password': signUpCtr.passwordController.text,
      'name': signUpCtr.nameController.text,
      'zipcode': signUpCtr.address1Controller.text,
      'account_id': signUpCtr.idController.text,
      'address': signUpCtr.address2Controller.text,
      'address_detail': signUpCtr.address3Controller.text,
      'certifi_id': phoneCtr.certifyId,
      'email': signUpCtr.emailController.text,
      'phone': phoneCtr.numberController.text,
      // 'birth_year': int.parse(signUpCtr.birthdayYear.text),
      // 'birth_month': int.parse(signUpCtr.birthdayMonth.text),
      // 'birth_day': int.parse(signUpCtr.birthdayDay.text),
    };
    log('before response');
    final response =
        await post(mConst.API_BASE_URL + mConst.API_USER_PATH + '/user', body);
    log('postUserSignUp response ${response.body}');

    if (response.statusCode == 200) {
      final raw = jsonDecode(response.bodyString!);
      log('postUserSignUp raw ' + raw.toString());
      log(response.bodyString!);
      return true;
    } else {
      var error = jsonDecode(response.bodyString!);
      mSnackbar(
          message: '오류: ${error["validation_errors"] ?? error["description"]}');
      return false;
    }
  }

  /// User Info Edit
  Future<bool> putUserInfoEdit() async {
    SignupOrEditController signUpCtr = Get.put(SignupOrEditController());

    Map<String, dynamic> body = {
      'name': signUpCtr.nameController.text,
      'zipcode': signUpCtr.address1Controller.text,
      'address': signUpCtr.address2Controller.text,
      'address_detail': signUpCtr.address3Controller.text,
      'email': signUpCtr.emailController.text,
    };

    print('putUserInfoEdit body ' + body.toString());

    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/me';
    final response = await put(url, body, headers: headers);
    log('putAddStoreFavorite $response');

    if (response.statusCode == 200) {
      log('response ${response.bodyString}');
      return true;
    } else {
      var jsonList = jsonDecode(response.bodyString!);
      log('error:' + jsonList.toString());
      mSnackbar(message: '에러가 발생했습니다. ${response.bodyString!}');
      return false;
    }
  }

  Future<bool> chekToken() async {

    Map<String, dynamic> body = {
      'access_token': CacheProvider().getToken()
    };

    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/login-check';
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

  /// Login page
  Future<StatusModel> postLogin_User(Map<String, dynamic> data) async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + mConst.LOGIN;
    final response = await post(url, data);
    log(response.statusCode.toString());
    log(jsonDecode(response.bodyString!).toString());

    var json = jsonDecode(response.bodyString!);

    String message = '';
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 0:
        message = 'Has Error';
        break;
      case 200:
        String token = json['access_token'];
        CacheProvider().setToken(token);
        log('setToken finished;');
        log('nrew token: ' + CacheProvider().getToken());
        // update value of headers with new token
        headers = {"Authorization": "Bearer " + CacheProvider().getToken()};
        message = '완료!';
        break;
      default:
        message = json['description'] ?? '';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  /// Home page
  Future<List<ImageBannerModel>> getBannerImageList() async {
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + mConst.EXHIBITION_BANNERS;
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);

      List<ImageBannerModel> imageBannerList = json
          .map<ImageBannerModel>((model) => ImageBannerModel.fromJson(model))
          .toList();
      return imageBannerList;
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<List<Product>> getAdProducts(UserHomeTabs currentTab) async {
    String apiPath = '';
    if (currentTab == UserHomeTabs.home) {
      apiPath = '/advertisement/home/products';
    } else if (currentTab == UserHomeTabs.newProduct) {
      apiPath = '/advertisement/new/products';
    }
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + apiPath;
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );

        products.add(tempProduct);
      }
      return products;
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<List<Product>> getAllProducts({
    required int offset,
    required int limit,
    int? storeId,
    String? sort,
  }) async {
    String storeIdStr = storeId != null ? '&store_id=$storeId' : '';
    String sortStr = sort != null ? '&sort=$sort' : '';
    print(' etAllProducts sort $sort sortStr $sortStr');

    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/products?offset=$offset&limit=$limit' +
        storeIdStr +
        sortStr;

    print('getAllProducts url $url');

    final response = await get(url, headers: headers);
    // log('getAllProducts response ${response.body}');

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      log('error getProducts : ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  Future<List<Product>> getProductsWithCat(
      {required int categoryId,
      required int offset,
      required int limit,
      int? storeId,
      String? sort}) async {
    print('getProductsWithCat> cat id: $categoryId');
    print('getProductsWithCat> offset: $offset');
    print('getProductsWithCat> limit: $limit');
    print('getProductsWithCat> sort: $sort');

    String storeIdStr = storeId != null ? '&store_id=$storeId' : '';
    String sortStr = sort != null ? '&sort=$sort' : '';

    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/category/$categoryId/products?offset=$offset&limit=$limit' +
        storeIdStr +
        sortStr;
    print('getProductsWithCat> url: $url');

    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      log('error getProducts : ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  Future<List<Product>> getNewProducts(
      {required int offset, required int limit}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        mConst.PRODUCTS +
        '?offset=$offset&limit=$limit';
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      log('error getNewProducts ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  Future<List<Product>> getBestProductsWithALL({required String sort}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/product/bests?sort=$sort';

    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          imgHeight: 230,
          imgWidth: 184,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      // var jsonList = jsonDecode(response.bodyString!);
      log('error getBestProducts ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  Future<List<Product>> getBestProductsWithCat(
      {required int categoryId, required String sort}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/category/$categoryId/product/bests?sort=$sort';

    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          imgHeight: 230,
          imgWidth: 184,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      // var jsonList = jsonDecode(response.bodyString!);
      log('error getBestProducts ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// ############ home > 띵동 Tab
  Future<List<Product>> getDingdongProductPopular(
      {required int offset, required int limit}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        mConst.PRODUCTS +
        '/privilege/popular?offset=$offset&limit=$limit';
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      // var jsonList = jsonDecode(response.bodyString!);

      log('error getDingdongProductPopular ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  Future<List<Product>> getDingdongProductsWithCat(
      {required int categoryId,
      required int offset,
      required int limit}) async {
    log('cat id: $categoryId');
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/category/$categoryId/products/privilege?offset=$offset&limit=$limit';

    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      var jsonList = jsonDecode(response.bodyString!);

      log('error:' + jsonList.toString());
      return Future.error(response.statusText!);
    }
  }

  Future<List<ImageBannerModel>> getDingdongBanners() async {
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + mConst.THINK_BANNERS;
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      List<ImageBannerModel> imageBannerList = json
          .map<ImageBannerModel>((model) => ImageBannerModel.fromJson(model))
          .toList();
      return imageBannerList;
    } else {
      return Future.error(response.statusText!);
    }
  }

  // Ding's pick page
  Future<List<Product>> getDingsPick(
      {required int offset, required int limit}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/advertisement/pick/products?offset=$offset&limit=$limit';
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          imgHeight: 145,
          imgWidth: 116,
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      // var jsonList = jsonDecode(response.bodyString!);

      log('error getDingsPick ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// Store Page
  Future<List<Store>> getStoreRanking(
      {required int offset, required int limit}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/store/ranking-list?type=total&offset=$offset&limit=$limit';
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Store> stores = [];

      for (int i = 0; i < jsonList.length; i++) {
        Store tempStore = Store(
          id: jsonList[i]['store_id'],
          name: jsonList[i]['store_name'],
          imgUrl: jsonList[i]['store_thumbnail_image_url'] != null
              ? (jsonList[i]['store_thumbnail_image_url'] as String).obs
              : null,
          isBookmarked: jsonList[i]['is_favorite'] ? true.obs : false.obs,
          rank: i + 1,
        );
        stores.add(tempStore);
      }

      return stores;
    } else {
      // var jsonList = jsonDecode(response.bodyString!);

      return Future.error(response.statusText!);
    }
  }

  /// Store Page
  Future<List<Store>> getStorebookmarked() async {
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/store/favorites';
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Store> stores = [];

      for (int i = 0; i < jsonList.length; i++) {
        Store tempStore = Store(
          id: jsonList[i]['store_id'],
          name: jsonList[i]['store_name'],
          imgUrl: jsonList[i]['store_thumbnail_image_url'] != null
              ? (jsonList[i]['store_thumbnail_image_url'] as String).obs
              : null,
          isBookmarked: jsonList[i]['is_favorite'] ? true.obs : false.obs,
          rank: i + 1,
        );
        stores.add(tempStore);
      }
      log('getStorebookmarked ${stores.length}');
      return stores;
    } else {
      var jsonList = jsonDecode(response.bodyString!);

      log('error:' + jsonList.toString());
      return Future.error(response.statusText!);
    }
  }

  /// Store Page
  Future<bool> putAddStoreFavorite({required int storeId}) async {
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/store/$storeId/favorite';
    final response = await put(url, 'empty_body', headers: headers);
    log('putAddStoreFavorite $response');

    if (response.statusCode == 200) {
      log('response ${response.bodyString}');
      return true;
    } else {
      var jsonList = jsonDecode(response.bodyString!);
      log('error:' + jsonList.toString());
      return Future.error(response.statusText!);
    }
  }

  // page 4: 찜 상품
  Future<List<Product>> getFavoriteProducts() async {
    headers={"Authorization": "Bearer " + CacheProvider().getToken()};
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/product/favorites';
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      // var jsonList = jsonDecode(response.bodyString!);

      log('error getFavoriteProducts: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  // My page
  Future<User> getUserInfo() async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/me';
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      User user = await User(
        userID: json['account_id'],
        userName: json['name'],
        points: (json['point'] as int).obs,
        waitingReviewCount: json['waiting-review-count'],
        isAgreeNotificaiton: (json['is_agree_notification'] as bool).obs,
        email: json['email'],
        birthday: DateTime(int.parse(json['birth_year']),
            int.parse(json['birth_month']), int.parse(json['birth_day'])),
        address: Address(
          address: json['address'],
          addressDetail: json['address_detail'],
          addressType: 'R',
          zipCode: json['zipcode'],
          requestMessage: '',
        ),
      );
      return user;
    } else {
      // var jsonList = jsonDecode(response.bodyString!);
      log('error getUserInfo: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// Like, unlike product
  Future<bool> putProductLikeToggle({required int productId}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/product/$productId/favorite';
    final response = await put(url, 'empty_body', headers: headers);
    log('putAddStoreFavorite $response');

    if (response.statusCode == 200) {
      log('response ${response.bodyString}');
      return true;
    } else {
      var jsonList = jsonDecode(response.bodyString!);
      log('error:' + jsonList.toString());
      return Future.error(response.statusText!);
    }
  }

  /// My page > review
  Future<List<OrderOrReview>> getUserReviews() async {
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/order/waiting-reviews';
    final response = await get(url, headers: headers);
    log('getUserReviews response: ${response.bodyString}');

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);

      List<OrderOrReview> orders = [];

      for (var json in jsonList) {
        DateTime date = DateTime.parse(json['created_at']);

        // create products list
        List<Product> products = [];
        for (var orderDetail in json['order_details']) {
          Store tempStore = Store(
            id: orderDetail['store_id'],
            name: orderDetail['store_name'],
          );

          Product tempProduct = Product(
            id: orderDetail['product_id'],
            title: orderDetail['product_name'],
            price: orderDetail['product_price'],
            quantity: (orderDetail['product_order_qty'] as int).obs,
            showQuantityPlusMinus: true,
            selectedOptionAddPrice: orderDetail['product_add_price'],
            OLD_option: orderDetail['product_option_name'],
            imgHeight: 90,
            imgWidth: 72,
            imgUrl: orderDetail['product_thumbnail_url'],
            store: tempStore,
            orderStatus: orderDetail['order_status_code'],
            isReviewWritten: orderDetail['is_regist_review'],
            hasBellIconAndBorder: json['is_privilege'],
            orderDetailId: orderDetail['id'],
          );

          products.add(tempProduct);
        }

        print('json["order_id"] ${json['order_id']}');

        OrderOrReview order = OrderOrReview(
          id: json['order_id'],
          user: User.dummy1(),
          products: products,
          address: Address.dummy(),
          date: date,
          orderNumber: json['code'],
          paymentMethod: "paymentMethod",
          deliveryFee: 1111111,
          pointUsed: 11111111,
        );
        orders.add(order);
      }
      print('getUserReviews orders ${orders.length}');
      return orders;
    } else {
      // var jsonList = jsonDecode(response.bodyString!);
      log('error getUserInfo: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// 마이페이지 > 주문 조회
  Future<List<OrderOrReview>> getOrderInquiry(
      {required int offset, required int limit, required String period}) async {
    print(
        ' getOrderInquiry offset: $offset, limit: $limit, period: $period');
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/orders?offset=$offset&limit=$limit&periodType=$period';
    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      print('getOrderInquiry jsonList: ${jsonList.toString()}');

      List<OrderOrReview> orders = [];

      for (var json in jsonList) {
        DateTime date = DateTime.parse(json['created_at']);

        // create products list
        List<Product> products = [];
        for (var product in json['order_details']) {
          Store tempStore = Store(
            id: product['store_id'],
            name: product['store_name'],
          );

          Product tempProduct = Product(
            id: product['product_id'],
            title: product['product_name'],
            showQuantityPlusMinus: false,
            quantity: (product['product_order_qty'] as int).obs,
            selectedOptionAddPrice: product['product_add_price'],
            OLD_option: product['product_option_name'],
            imgHeight: 90,
            imgWidth: 72,
            imgUrl: product['product_thumbnail_url'],
            store: tempStore,
            orderStatus: product['order_status_code'],
            orderDetailId: product['id'],
            delivery_company_name:product['delivery_company_name'],
            delivery_invoice_number:product['delivery_invoice_number'],
            isReviewWritten: product['is_regist_review'],
            hasBellIconAndBorder: json['is_privilege'],
            price: product['product_price'],
          );

          products.add(tempProduct);
        }

        OrderOrReview order = OrderOrReview(
          id: json['order_id'],
          user: User.dummy1(),
          products: products,
          address: Address.dummy(),
          date: date,
          orderNumber: json['code'] != null ? json['code'] : -1111111,
          paymentMethod: "paymentMethod",
          deliveryFee: 1111111,
          pointUsed: 11111111,
        );
        orders.add(order);
      }
      return orders;
    } else {
      // var jsonList = jsonDecode(response.bodyString!);
      log('error getUserInfo: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// 마이페이지 > 주문 상세
  Future<OrderOrReview> getOrderDetail({required int orderId}) async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/order/$orderId';
    final response = await get(url, headers: headers);
    log('getOrderDetail response: ${response.bodyString}');

    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);

      DateTime date = DateTime.parse(json['created_at']);

      // create products list
      List<Product> products = [];
      for (var orderDetailsJSON in json['order_details']) {
        Store tempStore = Store(
          id: orderDetailsJSON['store_id'],
          name: orderDetailsJSON['store_name'],
        );

        Product tempProduct = Product(
          id: orderDetailsJSON['product_id'],
          title: orderDetailsJSON['product_name'],
          showQuantityPlusMinus: false,
          quantity: (orderDetailsJSON['product_order_qty'] as int).obs,
          selectedOptionAddPrice: orderDetailsJSON['product_add_price'],
          OLD_option: orderDetailsJSON['product_option_name'],
          imgHeight: 90,
          imgWidth: 72,
          imgUrl: orderDetailsJSON['product_thumbnail_url'],
          store: tempStore,
          orderStatus: orderDetailsJSON['order_status_code'],
          isReviewWritten: orderDetailsJSON['is_regist_review'],
          hasBellIconAndBorder: json['is_privilege'],
          delivery_company_name:orderDetailsJSON['delivery_company_name'],
          delivery_invoice_number:orderDetailsJSON['delivery_invoice_number'],
        );

        products.add(tempProduct);
      }

      // Address
      var deliveryInfoJSON = json['delivery_info'];
      Address tempAddress = Address(
        address: deliveryInfoJSON['address'],
        addressDetail: deliveryInfoJSON['address_detail'],
        addressType: 'R',
        zipCode: deliveryInfoJSON['zipcode'],
        requestMessage: deliveryInfoJSON['request_comment'],
      );

      // User
      User tempUser = User(
        userID: '00000',
        userName: deliveryInfoJSON['orderer_name'],
        phoneNumber: deliveryInfoJSON['phone'],
      );

      OrderOrReview order = OrderOrReview(
        id: json['id'],
        user: tempUser,
        products: products,
        address: tempAddress,
        date: date,
        orderNumber: json['code'],
        delivery_company_name:json['delivery_company_name'],
        delivery_invoice_number:json['delivery_invoice_number'],
        paymentMethod: json['payment_info']['pay_method'] ?? '',
        deliveryFee: json['payment_info']['delivery_cost'],
        pointUsed: json['payment_info']['using_point'],
        totalPayAmount: json['payment_info']['total_pay_amount'],
        product_amount: json['payment_info']['product_amount'],
      );

      return order;
    } else {
      // var jsonList = jsonDecode(response.bodyString!);
      log('error getUserInfo: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// Product Detail Page
  Future<Product> getProductDetail({required int productId}) async {
    String url;
    if (MyVars.isUserProject()) {
      url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/product/$productId';
    } else {
      url = mConst.API_BASE_URL + mConst.API_STORE_PATH + '/product/$productId';
    }

    final response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);

      // Store info
      Store tempStore = Store(
        id: json['store_info']['id'],
        name: json['store_info']['name'],
        imgUrl: json['store_info']['thumbnail_image_url'] != null
            ? (json['store_info']['thumbnail_image_url'] as String).obs
            : null,
        isBookmarked:
            json['store_info']['is_favorite'] == true ? true.obs : false.obs,
      );

      // product images
      List<String> images = [];
      for (var image in json['images']) {
        images.add(image);
      }

      // product options
      List<ProductOptionModel> options = [];
      for (var oprionJSON in json['options']) {
        options.add(ProductOptionModel.fromJson(oprionJSON));
      }

      // product sizes
      List<ProductSizeModel> sizes = [];
      for (var sizeJSON in json['sizes']) {
        sizes.add(ProductSizeModel.fromJson(sizeJSON));
      }

      // materials
      List<ProductMaterial> materials = [];
      for (var materialJSON in json['materials']) {
        materials.add(ProductMaterial.fromJson(materialJSON));
      }

      // colors
      List<String> colors = [];
      for (var colorJSON in json['colors']) {
        colors.add(colorJSON);
      }

      // product
      Product tempProduct = Product(
        id: json['id'],
        title: json['name'],
        imgUrl: '',
        store: tempStore,
        images: images,
        price: json['price'],
        totalRating: json['review_score'] != null
            ? double.parse(json['review_score'].toString()).obs
            : null,
        options: options,
        hasBellIconAndBorder: json['is_privilege'],
        content: (json['content'] as String).obs,
        sizes: sizes,
        isLiked: json['is_favorite'] == true ? true.obs : false.obs,
        clothDetailSpec:
            ProductClothDetailSpec.fromJson(json['clothing_detail_spec']),
        clothCaringGuide:
            ProductClothCaringGuide.fromJson(json['clothing_care_guide']),
        productModelInfo: ProductModelInfo.fromJson(json['model_info']),
        return_exchange_info: json['return_exchange_info'],
        colors: colors,
        materials: materials,
      );

      return tempProduct;
    } else {
      log('error getProductDetail: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// Product Detail Page > Tab 2 Review
  Future<List<Review>> getProductReviews(
      {required int productId, required int offset, required int limit}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/product/$productId/reviews?offset=$offset&limit=$limit';
    final response = await get(url, headers: headers);
    log('getProductReviews response: ${response.bodyString}');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);

      WritableReviewInfoModel writableReviewInfoModel =
          WritableReviewInfoModel.fromJson(json['writable_review_info']);
      print(
          'writableReviewInfoModel ${writableReviewInfoModel.order_detail_id}');

      // Review list
      List<Review> tempReviews = [];
      for (var reviewJSON in json['review_list']) {
        // product
        Product tempProduct = Product(
          id: reviewJSON['product_info']['product_id'],
          title: reviewJSON['product_info']['name'],
          imgUrl: reviewJSON['product_info']['thumbnail_image_url'],
          OLD_option: reviewJSON['product_info']['option_name'],
          price: reviewJSON['product_info']['price'],
          selectedOptionAddPrice: reviewJSON['product_info']['add_price'],
          imgHeight: 62,
          imgWidth: 50,
          store: Store(id: -1),
        );

        // user
        User tempUser = User(
          userID: "userID",
          userName: reviewJSON['writer'],
        );

        // review
        Review tempReview = Review(
          id: reviewJSON['id'],
          user: tempUser,
          content: reviewJSON['content'],
          rating: double.parse(reviewJSON['star'].toString()),
          ratingType: ProductRatingType.star,
          date: DateTime.parse(reviewJSON['created_at']),
          createdAt: reviewJSON['created_at'],
          product: tempProduct,
          isMine: reviewJSON['is_mine'],
          reviewImageUrl: reviewJSON['review_image_url'],
          writableReviewInfoModel: writableReviewInfoModel,
        );
        tempReviews.add(tempReview);
      }
      return tempReviews;
    } else {
      log('error getUserInfo: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// Product detail > tab 2 reviews > deleteReview
  Future<StatusModel> deleteReview({required int reviewId}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/product/review/$reviewId';

    final response = await delete(url, headers: headers);
    var json = jsonDecode(response.bodyString!);
    String message = '';
    int statusCode = response.statusCode ?? 0;

    switch (statusCode) {
      case 0:
        message = response.bodyString!;
        break;
      case 200:
        message = '삭제되었습니다.';
        break;
    }
    return StatusModel(statusCode: statusCode, message: message);
  }

  /// Product Detail Page > Add Inquiry
  Future<bool> postAddInquiry(
      {required int productId,
      required String content,
      required bool isSecret}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/products/$productId/inquiry';

    Map<String, dynamic> data = {
      'content': content,
      'is_secret': isSecret,
    };

    final response = await post(url, data, headers: headers);
    log(response.statusCode.toString());
    log(jsonDecode(response.bodyString!).toString());

    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      mSnackbar(message: '문의 등록이 완료되였습니다.');
      return true;
    } else {
      log('error getUserInfo: ${response.bodyString}');
      mSnackbar(message: '오류: ' + response.statusText!);
      return false;
    }
  }

  /// Product Detail Page > Tab 3 Inquiry
  Future<List<InquiryModel>> getProductInquiries(
      {required int productId}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/product/$productId/inquiries';
    final response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);

      List<InquiryModel> tempInquiries = [];
      for (var inquiry in json) {
        InquiryModel tempInquiry = InquiryModel.fromJson(inquiry);
        tempInquiries.add(tempInquiry);
      }
      return tempInquiries;
    } else {
      log('error getUserInfo: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// Cart 1 : Shoppint basket
  Future<List<Cart>> getCart1ShoppintBasket() async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/carts';
    final response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);

      List<Cart> cartItems = [];
      for (var cart in json) {
        List<Product> products = [];
        // Store info
        Store tempStore = Store(
          id: cart['store_id'],
          name: cart['store_name'],
          imgUrl: cart['store_thumbnail_image_url'] != null
              ? (cart['store_thumbnail_image_url'] as String).obs
              : null,
        );

        for (var productJSON in cart['items']) {
          // product
          Product tempProduct = Product(
            id: productJSON['product_id'],
            title: productJSON['product_name'],
            store: tempStore,
            price: productJSON['price'] as int,
            selectedOptionId: productJSON['product_option_id'],
            selectedOptionAddPrice: productJSON['add_price'],
            OLD_option: productJSON['option_name'],
            imgUrl: productJSON['image_thumbnail_url'],
            quantity: (productJSON['qty'] as int).obs,
            showQuantityPlusMinus: true,
            isSoldout: productJSON['is_sold_out'] == "Y" ? true.obs : false.obs,
            imgHeight: 90,
            imgWidth: 72,
            isCheckboxSelected: false.obs,
            cartId: productJSON['cart_id'],
          );
          products.add(tempProduct);
        }
        cartItems.add(Cart(store: tempStore, products: products.obs));
      }
      return cartItems;
    } else {
      log('error getCart1ShoppintBasket: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// review detail page -> upload review image
  Future<ProductImageModel> postUploadReviewImage(
      {required XFile pickedImage}) async {
    print('postUploadReviewImage');
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/product/review-image';
    File image = File(pickedImage.path);
    String imageName = image.path.split('/').last;
    FormData formData = FormData({
      "image": MultipartFile(image, filename: imageName),
    });

    final response = await post(url, formData, headers: headers);

    print('uploadProductImage response ${response.bodyString}');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      return ProductImageModel(
          statusCode: response.statusCode ?? 0,
          message: response.statusText ?? '',
          url: json['url'],
          path: json['file_path']);
    } else {
      return ProductImageModel(
          statusCode: response.statusCode ?? 0,
          message: response.statusText ?? '',
          url: '',
          path: '');
    }
  }

  /// review detail page -> edit review
  Future<void> postReviewEdit(
      {required int reviewId,
      required String content,
      required String image_path,
      required int star}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/product/review/$reviewId';

    Map<String, dynamic> data = {
      'content': content,
      'image_path': image_path,
      'star': star,
    };
    final response = await post(url, data, headers: headers);

    print('uploadProductImage response ${response.bodyString}');
    mSnackbar(message: response.bodyString!);
  }

  /// review detail page -> Add new review
  Future<bool> postReviewAdd(
      {required int orderDetailId,
      required String content,
      String? image_path,
      required double star}) async {
    print(
        'postReviewAdd: orderDetailId $orderDetailId content $content image_path $image_path star $star');
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/order/detail/$orderDetailId/review';

    Map<String, dynamic> data = {
      'content': content,
      'image_path': image_path,
      'star': star,
    };

    final response = await post(url, data, headers: headers);

    print('postReviewAdd response ${response.bodyString}');
    if (response.statusCode == 200) {
      mSnackbar(message: '정상적으로 등록 되었습니다.');
      return true;
    } else {
      mSnackbar(message: '오류: ${response.bodyString}');
      return false;
    }
  }

  /// Search Page : Store Auto Complete
  Future<List<SearchStoreAutoModel>> getSearchStoreAutoComplete(
      {required String searchContent}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/search/stores?searchContent=$searchContent';

    final response = await get(url, headers: headers);
    print('getSearchStoreAutoComplete response: ${response.bodyString}');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      List<SearchStoreAutoModel> stores = [];
      for (var storeSearch in json) {
        SearchStoreAutoModel temp = SearchStoreAutoModel(
          storeId: storeSearch['store_id'],
          storeThumbnailImageUrl: storeSearch['store_thumbnail_image_url'],
          storeName: storeSearch['store_name'],
          isFavorite: storeSearch['is_favorite'],
        );
        stores.add(temp);
      }
      return stores;
    } else {
      log('error getCart1ShoppintBasket: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// Search Page : Product Auto Complete
  Future<List<SearchProductAutoModel>> getSearchKeywordAutoComplete(
      {required String searchContent}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/search/product/keywords?searchContent=$searchContent';

    final response = await get(url, headers: headers);
    print(
        'getSearchProductAutoComplete response: ${response.bodyString}');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      List<SearchProductAutoModel> keywords = [];
      for (var keywordJson in json) {
        SearchProductAutoModel temp = SearchProductAutoModel(
          id: keywordJson['id'],
          keyword: keywordJson['keyword'],
        );
        keywords.add(temp);
      }
      return keywords;
    } else {
      log('error getCart1ShoppintBasket: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// Cart 1 page > delete products from cart
  Future<bool> deleteProductsFromCart(List<int> cart_id_list) async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/carts';

    Map<String, dynamic> data = {
      'cart_id_list': cart_id_list,
      // 'cart_id_list': [4],
    };

    final response = await put(url, data, headers: headers);
    print(
        'deleteProductsFromCart response.bodyString! ${response.bodyString!}');

    if (response.statusCode == 200) {
      return true;
    } else {
      mSnackbar(message: '오류: ${response.bodyString}');
      return false;
    }
  }

  /// Product detail > add to basket
  Future<bool> postAddToShoppingBasket(
      int product_option_id, int quantity) async {
    Map<String, dynamic> data = {
      'product_option_id': product_option_id,
      'qty': quantity,
    };
    Map<String, dynamic> dataHolder = {
      'carts': [data],
    };

    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/cart';

    print('dataHolder $dataHolder');

    final response = await post(url, dataHolder, headers: headers);
    print('postAddToShoppingBasket ${response.bodyString}');

    if (response.statusCode == 200) {
      return true;
    } else {
      //mSnackbar(message: '오류: ${response.bodyString}');
      return false;
    }
  }

  //  Recently Seen Products
  Future<List<Product>> getRecentlySeenProducts(List productIds) async {
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/product-packaged';

    Map<String, dynamic> data = {
      'ids': productIds,
    };

    final response = await put(url, data, headers: headers);
    print('getRecentlySeenProducts ${response.bodyString}');

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      log('error getRecentlySeenProducts: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  /// Product detail > edit review
  Future<bool> putReviewEdit(
      {required int reviewId,
      required String content,
      required String image_path,
      required double star}) async {
    print(
        'putReviewEdit reviewId $reviewId content $content image_path $image_path star $star');

    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/product/review/$reviewId';

    Map<String, dynamic> data = {
      'content': content,
      'image_path': image_path,
      'star': star,
    };

    final response = await put(url, data, headers: headers);
    log('putReviewEdit $response');

    if (response.statusCode == 200) {
      log('response ${response.bodyString}');
      return true;
    } else {
      var jsonList = jsonDecode(response.bodyString!);
      log('putReviewEdit error:' + jsonList.toString());
      mSnackbar(message: '오류: ${response.bodyString!}');
      return Future.error(response.statusText!);
    }
  }

  /// Store detail Page
  Future<MainStoreModel> getStoreDetailMainInfo(int storeId) async {
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/store/$storeId/main';

    final response = await get(url, headers: headers);
    print('getStoreDetailMainInfo ${response.bodyString}');

    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      return MainStoreModel.fromJson(json);
    } else {
      log('error getStoreDetailMainInfo: ${response.bodyString}');
      return Future.error(response.statusText!);
    }
  }

  // Store detail > top10
  Future<List<Product>> getTop10Products({required int storeId}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/store/$storeId/best-products';

    final response = await get(url, headers: headers);
    print('getBestProducts ${response.bodyString}');

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);

      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );
        products.add(tempProduct);
      }
      return products;
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// my page > 문의내역
  Future<List<InquiriesPageModel>> getInquiryList({required int limit}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/product/inquiries/mine?limit=$limit';

    final response = await get(url, headers: headers);
    print('getInquiryList ${response.bodyString}');

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<InquiriesPageModel> inquries = [];
      for (var json in jsonList) {
        inquries.add(InquiriesPageModel.fromJson(json));
      }

      return inquries;
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// my page > FAQ 자주 묻는 질문
  Future<List<FaqPageModel>> getFaq() async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/faq';

    final response = await get(url, headers: headers);
    log('getFaq ${response.bodyString}');

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<FaqPageModel> FAQs = [];
      for (var json in jsonList) {
        FAQs.add(FaqPageModel.fromJson(json));
      }

      return FAQs;
    } else {
      return Future.error(response.statusText!);
    }
  }

  // Point mgmt page
  Future<List<PointMgmtPageModel>> getPointMgmtListForUser() async {
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/point-histories';

    final response = await get(url, headers: headers);
    print('getPointMgmtList ${response.bodyString}');

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<PointMgmtPageModel> pointMgmt = [];
      for (var json in jsonList) {
        pointMgmt.add(PointMgmtPageModel.fromJson(json));
      }
      return pointMgmt;
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<List<BulletinModel>> getUserBulletins() async {
    final response = await get(
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/notice-boards',
        headers: headers);
    print('getUserBulletins ${response.bodyString}');
    if (response.statusCode == 200) {
      Iterable raw = jsonDecode(response.bodyString!);
      List<BulletinModel> bulletins =
          raw.map((model) => BulletinModel.fromJson(model)).toList();

      return bulletins;
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// Cart 1 page > 구매하기 button
  Future<Cart2CheckoutModel> postOrderCheckout(
      Cart1OrdersModel cart1ordersModel) async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/checkout';

    final response =
        await post(url, cart1ordersModel.toJson(), headers: headers);
    print('postOrderCheckout ${response.bodyString}');

    if (response.statusCode == 200) {
      var json = jsonDecode(response.bodyString!);
      return Cart2CheckoutModel.fromJson(json);
    } else {
      log('error postOrderCheckout: ${response.bodyString}');
      mSnackbar(message: '오류: ${response.bodyString!}');
      return Future.error(response.statusText!);
    }
  }

  Future<bool> postPaymentSucessfullyFinished({
    required String imp_uid,
    required String merchant_uid,
    required int checkout_id,
    required int use_point,
    required String orderer_name,
    required String zipcode,
    required String address,
    required String address_detail,
    required String phone,
    required String request_message,
  }) async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/order/complete';

    Map<String, dynamic> data = {};
    data['imp_uid'] = imp_uid;
    data['merchant_uid'] = merchant_uid.toString();
    data['checkout_id'] = checkout_id;
    data['use_point'] = use_point;
    data['orderer_name'] = orderer_name;
    data['zipcode'] = zipcode;
    data['address'] = address;
    data['address_detail'] = address_detail;
    data['phone'] = phone;
    data['request_message'] = request_message;

    print('postPaymentSucessfullyFinished: $data');

    final response = await post(url, data, headers: headers);
    print('postPaymentSucessfullyFinished data: ${response.bodyString}');

    if (response.statusCode == 200) {
      return true;
    } else {
      log('error postPaymentSucessfullyFinished.');
      mSnackbar(message: '오류: ${response.bodyString!}');
      return false;
    }
  }

  Future<List<Product>> getSearchProducts(
      {required String searchContent,
      required int offset,
      required int limit}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/search/products?searchContent=$searchContent&offset=$offset&limit=$limit';

    final response = await get(url, headers: headers);
    print('getSearchProducts response: ${response.bodyString}');
    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.bodyString!);
      List<Product> products = [];

      for (var json in jsonList) {
        Store tempStore = Store(
          id: json['store_id'],
          name: json['store_name'],
        );

        Product tempProduct = Product(
          id: json['id'],
          title: json['product_name'],
          store: tempStore,
          price: json['price'],
          isLiked: json['is_favorite'] ? true.obs : false.obs,
          imgUrl: json['thumbnail_image_url'],
          hasBellIconAndBorder: (json['is_privilege'] as bool).obs,
        );

        products.add(tempProduct);
      }
      return products;
    } else {
      return Future.error(response.statusText!);
    }
  }

  // 주문 > 주소 검색
  Future<int> getDeliveryFee(
      {required int checkout_id,
      required String postCode,
      required String address}) async {
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/chechkout/$checkout_id/delivery';

    Map<String, dynamic> data = {};
    data['zipcode'] = postCode;
    data['address'] = address;

    final response = await put(url, data, headers: headers);
    log('getDeliveryFee $response');

    if (response.statusCode == 200) {
      log('response ${response.bodyString}');
      var json = jsonDecode(response.bodyString!);
      return json['delivery_cost'];
    } else {
      log('error:' + response.bodyString!);
      mSnackbar(message: '오류: ${response.bodyString!}');
      return Future.error(response.statusText!);
    }
  }

  Future<bool> changePassword(
      {required String originalPassword,
      required String newPassword,
      required String newPasswordVerify}) async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/me/password';

    Map<String, dynamic> data = {};
    data['current_password'] = originalPassword;
    data['new_password'] = newPassword;
    data['re_new_password'] = newPasswordVerify;

    dynamic response = await put(url, data, headers: headers);

    if (response.statusCode == 200) {
      log('response ${response.bodyString}');
      return true;
    } else {
      log('error:' + response.bodyString!);
      mSnackbar(message: '오류: ${response.bodyString!}');
      return false;
      // return Future.error(response.statusText!);
    }
  }

  // my page > settings > 탈퇴
  Future<bool> deleteUserAccount() async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/me';

    var response = await delete(url, headers: headers);
    log('deleteUserAccount $response');

    if (response.statusCode == 200) {
      log('response ${response.bodyString}');
      return true;
    } else {
      log('error:' + response.bodyString!);
      mSnackbar(message: '오류: ${response.bodyString!}');
      return false;
      // return Future.error(response.statusText!);
    }
  }

  orderSettled(int orderDetailId) async {
    print('orderSettled: orderDetailId $orderDetailId');
    String url = mConst.API_BASE_URL +
        mConst.API_USER_PATH +
        '/order/detail/$orderDetailId/purchase-confirm';
    // create put request
    final response = await put(url, 'empty_body', headers: headers);

    if (response.statusCode == 200) {
      log('response ${response.bodyString}');
      return true;
    } else {
      log('error:' + response.bodyString!);
      mSnackbar(message: '오류: ${response.bodyString!}');
      return false;
      // return Future.error(response.statusText!);
    }
  }

  Future<dynamic> changePhoneNumber(
      {required Map<String, dynamic> data}) async {
    String url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/me/phone';
    final response = await put(url, data, headers: headers);

    if (response.statusCode == 200) {
      mSnackbar(message: '전화번호가 변경되었습니다.');
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

  // PUT /fcm-token
  sendTCMToken(String fcmToken) async {
    String url = '';
    if (MyVars.isUserProject()) {
      url = mConst.API_BASE_URL + mConst.API_USER_PATH + '/fcm-token';
    } else {
      url = mConst.API_BASE_URL + mConst.API_STORE_PATH + '/fcm-token';
    }

    Map<String, dynamic> data = {};
    data['token'] = fcmToken;
    dynamic response = await put(url, {'token': fcmToken}, headers: headers);

    if (response.statusCode == 200) {
      log('sendTCMToken response ${response.bodyString}');
    } else {
      log('sendTCMToken error:' + response.bodyString!);
      //mSnackbar(message: '오류: ${response.bodyString!}');
    }
  }

  Future<bool> updateNotification() async {
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/notification-agree';
    dynamic response = await put(url, 'empty_body', headers: headers);

    if (response.statusCode == 200) {
      log('updateNotification response ${response.bodyString}');
      return true;
    } else {
      log('updateNotification error:' + response.bodyString!);
      mSnackbar(message: '${response.bodyString!['description']}');
      return false;
    }
  }

  changeQuantityInBasket({required int cartId, required int qty}) async {
    print('changeQuantityInBasket: cartId $cartId, qty $qty');
    String url =
        mConst.API_BASE_URL + mConst.API_USER_PATH + '/cart/$cartId/qty';

    Map<String, dynamic> body = {
      "qty": qty,
    };

    dynamic response = await put(url, body, headers: headers);

    if (response.statusCode == 200) {
      log('changeQuantityInBasket response ${response.bodyString}');
      return true;
    } else {
      log('changeQuantityInBasket error:' + response.bodyString!);
      mSnackbar(message: response.bodyString!['description']);
      return false;
    }
  }
}
