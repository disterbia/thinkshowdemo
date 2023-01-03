import 'package:wholesaler_partner/app/models/add_product/option.dart';

import 'material_list.dart';
import 'model_info.dart';
import 'option_list.dart';
import 'size_info_list.dart';

class ProductModifyModel {
  int? price;
  String? productName;
  int? mainCategoryId;
  int? subCategoryId;
  String? thumbnailImagePath;
  String? thumbnailImageUrl;
  String? colorImagePath;
  String? colorImageUrl;
  String? detailImagePath;
  String? detailImageUrl;
  bool? isPrivilege;
  ModelInfo? modelInfo;
  List<dynamic>? keywordList;
  List<MaterialList>? materialList;
  String? thickness;
  String? seeThrough;
  String? flexibility;
  bool? isLining;
  String? content;
  String? manufactureCountry;
  bool? isHandWash;
  bool? isDryCleaning;
  bool? isWaterWash;
  bool? isWoolWash;
  bool? isSingleWash;
  bool? isNotBleash;
  bool? isNotIroning;
  bool? isNotMachineWash;
  List<Option>? options;
  List<SizeInfoModel>? sizeInfoList;

  ProductModifyModel({
    this.productName,
    this.mainCategoryId,
    this.subCategoryId,
    this.thumbnailImagePath,
    this.thumbnailImageUrl,
    this.colorImagePath,
    this.colorImageUrl,
    this.detailImagePath,
    this.detailImageUrl,
    this.isPrivilege,
    this.modelInfo,
    this.keywordList,
    this.materialList,
    this.thickness,
    this.seeThrough,
    this.flexibility,
    this.isLining,
    this.content,
    this.manufactureCountry,
    this.isHandWash,
    this.isDryCleaning,
    this.isWaterWash,
    this.isSingleWash,
    this.isNotBleash,
    this.isNotIroning,
    this.isNotMachineWash,
    this.options,
    this.sizeInfoList,
    this.price,
    this.isWoolWash,
  });

  factory ProductModifyModel.fromJson(Map<String, dynamic> json) {
    return ProductModifyModel(
      productName: json['product_name'] as String?,
      price: json['price'] as int?,
      mainCategoryId: json['main_category_id'] as int?,
      subCategoryId: json['sub_category_id'] as int?,
      thumbnailImagePath: json['thumbnail_image_path'] as String?,
      thumbnailImageUrl: json['thumbnail_image_url'] as String?,
      colorImagePath: json['color_image_path'] as String?,
      colorImageUrl: json['color_image_url'] as String?,
      detailImagePath: json['detail_image_path'] as String?,
      detailImageUrl: json['detail_image_url'] as String?,
      isPrivilege: json['is_privilege'] as bool?,
      modelInfo: json['model_info'] == null ? null : ModelInfo.fromJson(json['model_info'] as Map<String, dynamic>),
      keywordList: json['keyword_list'] as List<dynamic>?,
      materialList: (json['material_list'] as List<dynamic>?)?.map((e) => MaterialList.fromJson(e as Map<String, dynamic>)).toList(),
      thickness: json['thickness'] as String?,
      seeThrough: json['see_through'] as String?,
      flexibility: json['flexibility'] as String?,
      isLining: json['is_lining'] as bool?,
      content: json['content'] as String?,
      manufactureCountry: json['manufacture_country'] as String?,
      isHandWash: json['is_hand_wash'] as bool?,
      isDryCleaning: json['is_dry_cleaning'] as bool?,
      isWaterWash: json['is_water_wash'] as bool?,
      isSingleWash: json['is_single_wash'] as bool?,
      isNotBleash: json['is_not_bleash'] as bool?,
      isWoolWash: json['is_wool_wash'] as bool?,
      isNotIroning: json['is_not_ironing'] as bool?,
      isNotMachineWash: json['is_not_machine_wash'] as bool?,
      options: (json['option_list'] as List<dynamic>?)?.map((e) => Option.fromJson(e as Map<String, dynamic>)).toList(),
      sizeInfoList: (json['size_info_list'] as List<dynamic>?)?.map((e) => SizeInfoModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'product_name': productName,
        'main_category_id': mainCategoryId,
        'sub_category_id': subCategoryId,
        'thumbnail_image_path': thumbnailImagePath,
        'thumbnail_image_url': thumbnailImageUrl,
        'color_image_path': colorImagePath,
        'color_image_url': colorImageUrl,
        'detail_image_path': detailImagePath,
        'detail_image_url': detailImageUrl,
        'is_privilege': isPrivilege,
        'model_info': modelInfo?.toJson(),
        'keyword_list': keywordList,
        'material_list': materialList?.map((e) => e.toJson()).toList(),
        'thickness': thickness,
        'see_through': seeThrough,
        'flexibility': flexibility,
        'is_lining': isLining,
        'content': content,
        'manufacture_country': manufactureCountry,
        'is_hand_wash': isHandWash,
        'is_dry_cleaning': isDryCleaning,
        'is_water_wash': isWaterWash,
        'is_wool_wash': isWoolWash,
        'is_single_wash': isSingleWash,
        'is_not_bleash': isNotBleash,
        'is_not_ironing': isNotIroning,
        'is_not_machine_wash': isNotMachineWash,
        'option_list': options?.map((e) => e.toJson()).toList(),
        'size_info_list': sizeInfoList?.map((e) => e.toJson()).toList(),
        'price': price,
      };
}
