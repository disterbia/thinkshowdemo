import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/size_child.dart';

class SizeCategory {
  int seunghanTestValue;
  List<SizeChild> children;
  SizeCategory({required this.children, required this.seunghanTestValue});

  static SizeCategory OUTER = SizeCategory(
    seunghanTestValue: ClothMainCategoryEnum.OUTER,
    children: [
      SizeChild.chest_cross_length,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.open,
      SizeChild.total_entry_length,
    ],
  );

  //   ClothMainCategoryEnum.TOP: ['어깨간면', '가슴단면', '암홀', '팔기장', '팔단면', '소매단면', '밑단단면', '총기장'],
  static SizeCategory TOP = SizeCategory(
    seunghanTestValue: ClothMainCategoryEnum.TOP,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
    ],
  );

  //   ClothMainCategoryEnum.PANTS: ['허리단면', '엉덩이단면', '밑위단면', '허벅지단면', '밑단단면', '총기장'],
  static SizeCategory PANTS = SizeCategory(
    seunghanTestValue: ClothMainCategoryEnum.PANTS,
    children: [
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.thigh_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
    ],
  );

  //   ClothMainCategoryEnum.SKIRTS: ['허리단면', '엉덩이단면', '밑단단면', '트임', '안감', '총기장'],
  static SizeCategory SKIRTS = SizeCategory(
    seunghanTestValue: ClothMainCategoryEnum.SKIRTS,
    children: [
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.strap,
      SizeChild.armhole,
      SizeChild.total_entry_length,
    ],
  );

  //   ClothMainCategoryEnum.ONE_PIECE: ['어깨간면', '가슴단면', '암홀', '팔기장', '팔단면', '소매단면', '밑단단면', '스트랩', '총기장'],
  static SizeCategory ONE_PIECE = SizeCategory(
    seunghanTestValue: ClothMainCategoryEnum.ONE_PIECE,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.strap,
      SizeChild.total_entry_length,
    ],
  );

  //   ClothMainCategoryEnum.SET: ['어깨간면 SET', '가슴단면', '암홀', '허리단면', '엉덩이단면', '허벅지단면', '밑위길이/미단길이', '총'],
  static SizeCategory SET = SizeCategory(
    seunghanTestValue: ClothMainCategoryEnum.SET,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.thigh_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
    ],
  );

  static SizeCategory getWithCatId(int catId) {
    if (catId == ClothMainCategoryEnum.OUTER) {
      return SizeCategory.OUTER;
    }
    if (catId == ClothMainCategoryEnum.TOP) {
      return SizeCategory.TOP;
    }
    if (catId == ClothMainCategoryEnum.PANTS) {
      return SizeCategory.PANTS;
    }
    if (catId == ClothMainCategoryEnum.SKIRTS) {
      return SizeCategory.SKIRTS;
    }
    if (catId == ClothMainCategoryEnum.ONE_PIECE) {
      return SizeCategory.ONE_PIECE;
    }
    if (catId == ClothMainCategoryEnum.SET) {
      return SizeCategory.SET;
    }
    return SizeCategory(children: [], seunghanTestValue: -1);
  }
}
