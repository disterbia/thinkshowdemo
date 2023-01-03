class ReviewModel {
  ReviewModel({
      this.id, 
      this.writer, 
      this.content, 
      this.reviewImageUrl, 
      this.reviewImagePath, 
      this.star, 
      this.isMine, 
      this.productInfo, 
      this.createdAt,});

  ReviewModel.fromJson(dynamic json) {
    id = json['id'];
    writer = json['writer'];
    content = json['content'];
    reviewImageUrl = json['review_image_url'];
    reviewImagePath = json['review_image_path'];
    star = json['star'];
    isMine = json['is_mine'];
    productInfo = json['product_info'] != null ? ProductInfo.fromJson(json['product_info']) : null;
    createdAt = json['created_at'];
  }
  int? id;
  String? writer;
  String? content;
  String? reviewImageUrl;
  String? reviewImagePath;
  int? star;
  bool? isMine;
  ProductInfo? productInfo;
  String? createdAt;
ReviewModel copyWith({  int? id,
  String? writer,
  String? content,
  String? reviewImageUrl,
  String? reviewImagePath,
  int? star,
  bool? isMine,
  ProductInfo? productInfo,
  String? createdAt,
}) => ReviewModel(  id: id ?? this.id,
  writer: writer ?? this.writer,
  content: content ?? this.content,
  reviewImageUrl: reviewImageUrl ?? this.reviewImageUrl,
  reviewImagePath: reviewImagePath ?? this.reviewImagePath,
  star: star ?? this.star,
  isMine: isMine ?? this.isMine,
  productInfo: productInfo ?? this.productInfo,
  createdAt: createdAt ?? this.createdAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['writer'] = writer;
    map['content'] = content;
    map['review_image_url'] = reviewImageUrl;
    map['review_image_path'] = reviewImagePath;
    map['star'] = star;
    map['is_mine'] = isMine;
    if (productInfo != null) {
      map['product_info'] = productInfo?.toJson();
    }
    map['created_at'] = createdAt;
    return map;
  }

}

class ProductInfo {
  ProductInfo({
      this.name, 
      this.optionName, 
      this.price, 
      this.addPrice, 
      this.thumbnailImageUrl,});

  ProductInfo.fromJson(dynamic json) {
    name = json['name'];
    optionName = json['option_name'];
    price = json['price'];
    addPrice = json['add_price'];
    thumbnailImageUrl = json['thumbnail_image_url'];
  }
  String? name;
  String? optionName;
  int? price;
  int? addPrice;
  String? thumbnailImageUrl;
ProductInfo copyWith({  String? name,
  String? optionName,
  int? price,
  int? addPrice,
  String? thumbnailImageUrl,
}) => ProductInfo(  name: name ?? this.name,
  optionName: optionName ?? this.optionName,
  price: price ?? this.price,
  addPrice: addPrice ?? this.addPrice,
  thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['option_name'] = optionName;
    map['price'] = price;
    map['add_price'] = addPrice;
    map['thumbnail_image_url'] = thumbnailImageUrl;
    return map;
  }

}