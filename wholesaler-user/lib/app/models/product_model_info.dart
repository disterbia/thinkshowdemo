class ProductModelInfo {
  dynamic height;
  dynamic modelWeight;
  dynamic modelSize;

  ProductModelInfo({this.height, this.modelWeight, this.modelSize});

  factory ProductModelInfo.fromJson(Map<String, dynamic> json) {
    return ProductModelInfo(
      height: json['height'] as dynamic,
      modelWeight: json['model_weight'] as dynamic,
      modelSize: json['model_size'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'height': height,
        'model_weight': modelWeight,
        'model_size': modelSize,
      };
}
