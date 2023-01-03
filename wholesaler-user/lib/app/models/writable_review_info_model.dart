class WritableReviewInfoModel {
  bool? is_writable;
  int? order_detail_id;

  WritableReviewInfoModel({required this.is_writable, required this.order_detail_id});

  WritableReviewInfoModel.fromJson(dynamic json) {
    is_writable = json['is_writable'];
    order_detail_id = json['order_detail_id'];
  }
}
