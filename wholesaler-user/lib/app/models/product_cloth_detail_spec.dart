class ProductClothDetailSpec {
  String? thickness;
  String? seeThrough;
  String? flexibility;
  bool? isLining;

  ProductClothDetailSpec({
    this.thickness,
    this.seeThrough,
    this.flexibility,
    this.isLining,
  });

  factory ProductClothDetailSpec.fromJson(Map<String, dynamic> json) {
    return ProductClothDetailSpec(
      thickness: json['thickness'] as String?,
      seeThrough: json['see_through'] as String?,
      flexibility: json['flexibility'] as String?,
      isLining: json['is_lining'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'thickness': thickness,
        'see_through': seeThrough,
        'flexibility': flexibility,
        'is_lining': isLining,
      };
}
