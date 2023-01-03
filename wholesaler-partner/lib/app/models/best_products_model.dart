class BestProductsModel {
  BestProductsModel({
      this.id, 
      this.storeId, 
      this.storeName, 
      this.isFavorite, 
      this.productName, 
      this.price, 
      this.thumbnailImageUrl, 
      this.mainCategoryId, 
      this.subCategoryId, 
      this.isSoldOut, 
      this.isPrivilege, 
      this.isAdvertisement, 
      this.advertisementProductId,});

  BestProductsModel.fromJson(dynamic json) {
    id = json['id'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    isFavorite = json['is_favorite'];
    productName = json['product_name'];
    price = json['price'];
    thumbnailImageUrl = json['thumbnail_image_url'];
    mainCategoryId = json['main_category_id'];
    subCategoryId = json['sub_category_id'];
    isSoldOut = json['is_sold_out'];
    isPrivilege = json['is_privilege'];
    isAdvertisement = json['is_advertisement'];
    advertisementProductId = json['advertisement_product_id'];
  }
  int? id;
  int? storeId;
  String? storeName;
  bool? isFavorite;
  String? productName;
  int? price;
  String? thumbnailImageUrl;
  int? mainCategoryId;
  int? subCategoryId;
  bool? isSoldOut;
  bool? isPrivilege;
  bool? isAdvertisement;
  dynamic advertisementProductId;
BestProductsModel copyWith({  int? id,
  int? storeId,
  String? storeName,
  bool? isFavorite,
  String? productName,
  int? price,
  String? thumbnailImageUrl,
  int? mainCategoryId,
  int? subCategoryId,
  bool? isSoldOut,
  bool? isPrivilege,
  bool? isAdvertisement,
  dynamic advertisementProductId,
}) => BestProductsModel(  id: id ?? this.id,
  storeId: storeId ?? this.storeId,
  storeName: storeName ?? this.storeName,
  isFavorite: isFavorite ?? this.isFavorite,
  productName: productName ?? this.productName,
  price: price ?? this.price,
  thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
  mainCategoryId: mainCategoryId ?? this.mainCategoryId,
  subCategoryId: subCategoryId ?? this.subCategoryId,
  isSoldOut: isSoldOut ?? this.isSoldOut,
  isPrivilege: isPrivilege ?? this.isPrivilege,
  isAdvertisement: isAdvertisement ?? this.isAdvertisement,
  advertisementProductId: advertisementProductId ?? this.advertisementProductId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['store_id'] = storeId;
    map['store_name'] = storeName;
    map['is_favorite'] = isFavorite;
    map['product_name'] = productName;
    map['price'] = price;
    map['thumbnail_image_url'] = thumbnailImageUrl;
    map['main_category_id'] = mainCategoryId;
    map['sub_category_id'] = subCategoryId;
    map['is_sold_out'] = isSoldOut;
    map['is_privilege'] = isPrivilege;
    map['is_advertisement'] = isAdvertisement;
    map['advertisement_product_id'] = advertisementProductId;
    return map;
  }

}