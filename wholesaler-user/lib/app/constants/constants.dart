class mConst {
  static const String AppName_Partner = "Wholesaler Partner";
  static const String AppName_User = "Wholesaler User";
  static const int SmallPhoneWidth = 375;
  static const double fixedImgWidth = 116;
  static const double fixedImgHeight = 145;
  static const int limit = 9;

  static const bool isTestMode = true;

  // ####### API Constants
  /// Server ip or domain address
  static const String API_BASE_URL = "https://api.thinksmk.com:3000";

  /// 도매 파트너, 판매자
  static const String API_STORE_PATH = "/v1/store-api";

  /// 도매 사용자
  static const String API_USER_PATH = "/v1/user-api";

  /// shared apis
  static const String API_COMMON_PATH = "/v1/common-api";

  // ###### COMMON APIs ######
  /// Common 휴대폰 인증 확인 API && 휴대폰 인증 요청 API
  static const String PHONE_NUM_VERIFY = "/certification/phone/";

  // ###### PARTNER APIs ######
  /// 스토어 위치 정보 조회
  static const String Partner_STORE_LOCATION = "/store-location";

  /// 회원가입 (대표/직원) -> ID 중복확인 API
  static const String Partner_ID_VERIFY = "/account-id/reduplication/";

  /// 회원가입 (대표/직원) -> 사업자등록증 이미지 업로드 API
  static const String BUSINESS_REGISTER_IMG_UPLOAD = "/business-license-photo";

  /// 회원가입 (대표/직원) -> 대표자 회원가입 API
  static const String CEO_REGISTER = "/owner";

  static const String ACCOUNT_ID = "/account-id";

  static const String PASSWORD = "/password";

  static const String CHECK = "/check";

  static const String LOGIN = "/login";

  static const String MAIN_TOP_IMAGE = "/store/main-top-image";

  static const String PRODUCT_IMAGE = "/product/image";

  static const String STORE_IMAGE = "/store/image";

  static const String STORE_THUMBNAIL_IMAGE = "/store/thumbnail-image";

  static const String NOTICE_BOARDS = "/notice-boards";

  static const String PRODUCT = "/product";

  static const String PRODUCTS = "/products";

  static const String ORDERS = "/orders";

  static const String STAFF_REGISTER = '/staff';

  static const String STORE_BEST_PRODUCTS = "/store/best-products";

  static const String ADVERTISEMENT_LIST = "/advertisement-list";

  static const String EXHIBITION_BANNERS = "/exhibition/banners";

  static const String THINK_BANNERS = "/think/banners";

  static const String RECOMMENDED_PRODUCTS = "/advertisement/new/products";
}
