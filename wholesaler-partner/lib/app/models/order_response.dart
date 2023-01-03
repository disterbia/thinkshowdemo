class OrderResponse {
  OrderResponse({
      this.totalAmount, 
      this.orders,});

  OrderResponse.fromJson(dynamic json) {
    totalAmount = json['total_amount'];
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders?.add(Orders.fromJson(v));
      });
    }
  }
  int? totalAmount;
  List<Orders>? orders;
OrderResponse copyWith({  int? totalAmount,
  List<Orders>? orders,
}) => OrderResponse(  totalAmount: totalAmount ?? this.totalAmount,
  orders: orders ?? this.orders,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_amount'] = totalAmount;
    if (orders != null) {
      map['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Orders {
  Orders({
    this.productId,
      this.orderId, 
      this.orderCode, 
      this.orderDetailId, 
      this.orderDetailCode, 
      this.productPrice, 
      this.productAddPrice, 
      this.orderQty, 
      this.productName, 
      this.productOptionName, 
      this.productThumbnailUrl, 
      this.orderStatusCode, 
      this.orderStatusName, 
      this.createdAt,});

  Orders.fromJson(dynamic json) {
    productId = json['product_id'];
    orderId = json['order_id'];
    orderCode = json['order_code'];
    orderDetailId = json['order_detail_id'];
    orderDetailCode = json['order_detail_code'];
    productPrice = json['product_price'];
    productAddPrice = json['product_add_price'];
    orderQty = json['order_qty'];
    productName = json['product_name'];
    productOptionName = json['product_option_name'];
    productThumbnailUrl = json['product_thumbnail_url'];
    orderStatusCode = json['order_status_code'];
    orderStatusName = json['order_status_name'];
    createdAt = json['created_at'];
  }
  int? orderId;
  int? productId;
  String? orderCode;
  int? orderDetailId;
  String? orderDetailCode;
  int? productPrice;
  int? productAddPrice;
  int? orderQty;
  String? productName;
  String? productOptionName;
  String? productThumbnailUrl;
  int? orderStatusCode;
  String? orderStatusName;
  String? createdAt;
Orders copyWith({  int? orderId,int? productId,
  String? orderCode,
  int? orderDetailId,
  String? orderDetailCode,
  int? productPrice,
  int? productAddPrice,
  int? orderQty,
  String? productName,
  String? productOptionName,
  String? productThumbnailUrl,
  int? orderStatusCode,
  String? orderStatusName,
  String? createdAt,
}) => Orders(  orderId: orderId ?? this.orderId,productId: productId,
  orderCode: orderCode ?? this.orderCode,
  orderDetailId: orderDetailId ?? this.orderDetailId,
  orderDetailCode: orderDetailCode ?? this.orderDetailCode,
  productPrice: productPrice ?? this.productPrice,
  productAddPrice: productAddPrice ?? this.productAddPrice,
  orderQty: orderQty ?? this.orderQty,
  productName: productName ?? this.productName,
  productOptionName: productOptionName ?? this.productOptionName,
  productThumbnailUrl: productThumbnailUrl ?? this.productThumbnailUrl,
  orderStatusCode: orderStatusCode ?? this.orderStatusCode,
  orderStatusName: orderStatusName ?? this.orderStatusName,
  createdAt: createdAt ?? this.createdAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['order_id'] = orderId;
    map['order_code'] = orderCode;
    map['order_detail_id'] = orderDetailId;
    map['order_detail_code'] = orderDetailCode;
    map['product_price'] = productPrice;
    map['product_add_price'] = productAddPrice;
    map['order_qty'] = orderQty;
    map['product_name'] = productName;
    map['product_option_name'] = productOptionName;
    map['product_thumbnail_url'] = productThumbnailUrl;
    map['order_status_code'] = orderStatusCode;
    map['order_status_name'] = orderStatusName;
    map['created_at'] = createdAt;
    return map;
  }

}