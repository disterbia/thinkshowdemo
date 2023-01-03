class InquiryModel {
  InquiryModel({
    this.id,
    this.writer,
    this.productInfo,
    this.content,
    this.answerContent,
    this.isAnswer,
    this.isSecret,
    this.createdAt,
    this.isMine,
  });

  InquiryModel.fromJson(dynamic json) {
    id = json['id'];
    writer = json['writer'];
    productInfo = json['product_info'] != null ? ProductInfo.fromJson(json['product_info']) : null;
    content = json['content'];
    answerContent = json['answer_content'];
    isAnswer = json['is_answer'];
    isSecret = json['is_secret'];
    isMine = json['is_mine'];
    createdAt = json['created_at'];
  }
  int? id;
  String? writer;
  ProductInfo? productInfo;
  String? content;
  String? answerContent;
  bool? isAnswer;
  bool? isSecret;
  String? createdAt;
  bool? isMine;
  InquiryModel copyWith({
    int? id,
    String? writer,
    ProductInfo? productInfo,
    String? content,
    String? answerContent,
    bool? isAnswer,
    bool? isSecret,
    String? createdAt,
  }) =>
      InquiryModel(
        id: id ?? this.id,
        writer: writer ?? this.writer,
        productInfo: productInfo ?? this.productInfo,
        content: content ?? this.content,
        answerContent: answerContent ?? this.answerContent,
        isAnswer: isAnswer ?? this.isAnswer,
        isSecret: isSecret ?? this.isSecret,
        createdAt: createdAt ?? this.createdAt,
        isMine: isMine ?? this.isMine,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['writer'] = writer;
    if (productInfo != null) {
      map['product_info'] = productInfo?.toJson();
    }
    map['content'] = content;
    map['answer_content'] = answerContent;
    map['is_answer'] = isAnswer;
    map['is_secret'] = isSecret;
    map['created_at'] = createdAt;
    map['is_mine'] = isMine;
    return map;
  }
}

class ProductInfo {
  ProductInfo({
    this.name,
    this.thumbnailImageUrl,
    this.productId,
  });

  ProductInfo.fromJson(dynamic json) {
    name = json['name'];
    thumbnailImageUrl = json['thumbnail_image_url'];
    productId = json['product_id'];
  }
  String? name;
  String? thumbnailImageUrl;
  int? productId;
  ProductInfo copyWith({
    String? name,
    String? thumbnailImageUrl,
    int? productId,
  }) =>
      ProductInfo(
        name: name ?? this.name,
        thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
        productId: productId ?? this.productId,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['thumbnail_image_url'] = thumbnailImageUrl;
    map['product_id'] = productId;
    return map;
  }
}
