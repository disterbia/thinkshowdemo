import 'package:get/state_manager.dart';
import 'package:wholesaler_partner/app/models/privilate_products_model.dart';

class MainStoreModel {
  MainStoreModel({
    this.storeId,
    this.storeName,
    this.mainTopImageUrl,
    this.isFavorite,
    this.privilegeProducts,
    this.settlementAmount,
  });

  MainStoreModel.fromJson(dynamic json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    mainTopImageUrl = json['main_top_image_url'] == null ? null : (json['main_top_image_url'] as String).obs;
    isFavorite = json['is_favorite'] != null && json['is_favorite'] ? true.obs : false.obs;
    settlementAmount = json['settlement_amount'];
    if (json['privilege_products'] != null) {
      privilegeProducts = [];
      json['privilege_products'].forEach((v) {
        privilegeProducts?.add(PrivilegeProducts.fromJson(v));
      });
    }
  }
  int? storeId;
  String? storeName;
  RxString? mainTopImageUrl;
  RxBool? isFavorite;
  int? settlementAmount;
  List<PrivilegeProducts>? privilegeProducts;
  MainStoreModel copyWith({
    int? storeId,
    String? storeName,
    String? mainTopImageUrl,
    RxBool? isFavorite,
    int? settlementAmount,
    List<PrivilegeProducts>? privilegeProducts,
  }) =>
      MainStoreModel(
        storeId: storeId ?? this.storeId,
        storeName: storeName ?? this.storeName,
        mainTopImageUrl: mainTopImageUrl!.obs,
        isFavorite: isFavorite ?? this.isFavorite,
        settlementAmount: settlementAmount ?? this.settlementAmount,
        privilegeProducts: privilegeProducts ?? this.privilegeProducts,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['store_id'] = storeId;
    map['store_name'] = storeName;
    map['main_top_image_url'] = mainTopImageUrl;
    map['is_favorite'] = isFavorite;
    map['settlementAmount'] = settlementAmount;
    if (privilegeProducts != null) {
      map['privilege_products'] = privilegeProducts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
