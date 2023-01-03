class ProductMaterial {
  String? name;
  int? ratio;

  ProductMaterial({this.name, this.ratio});

  factory ProductMaterial.fromJson(Map<String, dynamic> json) {
    return ProductMaterial(
      name: json['name'] as String?,
      ratio: json['ratio'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'ratio': ratio,
      };
}
