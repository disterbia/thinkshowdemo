enum SalesTab {
  Impressions,
  Clicks,
  Likes,
  Orders,
}

enum AdType {
  R,
  S,
  _1ST,
  _2ST,
  _3ST,
}

enum AdPaymentStatus {
  notPaid,
  paid,
}

enum AdTabs {
  Tab1AdStatus,
  //Tab2AdApplication,
  Tab3AdApplicationHistory,
}

enum BulletinType {
  bulletin,
  ad,
}

/// 회원가입 대표, 직원 건물
enum BuildingType {
  building,
  floor,
  unit,
}

enum ThicknessType {
  thick,
  middle,
  thin,
}

enum SeeThroughType {
  high,
  middle,
  none,
}

enum FlexibilityType {
  high,
  middle,
  none,
  banding,
}

class ProductMgmtButtons {
  static const String soldout = '품절';
  static const String top10 = 'TOP10';
  static const String dingdong = '띵동';
  static const String delete = '삭제';
}

class ClothMainCategoryEnum {
  static const int OUTER = 1;
  static const int TOP = 2;
  static const int PANTS = 3;
  static const int SKIRTS = 4;
  static const int ONE_PIECE = 5;
  static const int SET = 6;
}

class ProductFilterDates {
  static const String sameDay = '당일';
  static const String oneMonth = '1개월';
  static const String threeMonth = '3개월';
}

class SortProductDropDownItem {
  static const String latest = '최신순';
  static const String bySales = '판매순';
  static const String bySoldout = '품절순';
}
