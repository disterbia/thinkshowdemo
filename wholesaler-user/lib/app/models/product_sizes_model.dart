class ProductSizeModel {
  String? size;
  int? shoulderCrossLength;
  dynamic chestCrossLength;
  int? armhole;
  dynamic armStraightLength;
  dynamic armCrossLength;
  dynamic sleeveCrossLength;
  dynamic bottomCrossLength;
  dynamic strap;
  dynamic totalEntryLength;
  dynamic waistCrossLength;
  dynamic hipCrossLength;
  dynamic bottomTopCrossLength;
  dynamic thighCrossLength;
  dynamic open;
  dynamic lining;

  ProductSizeModel({
    this.size,
    this.shoulderCrossLength,
    this.chestCrossLength,
    this.armhole,
    this.armStraightLength,
    this.armCrossLength,
    this.sleeveCrossLength,
    this.bottomCrossLength,
    this.strap,
    this.totalEntryLength,
    this.waistCrossLength,
    this.hipCrossLength,
    this.bottomTopCrossLength,
    this.thighCrossLength,
    this.open,
    this.lining,
  });

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) {
    return ProductSizeModel(
      size: json['size'] as String?,
      shoulderCrossLength: json['shoulder_cross_length'] as int?,
      chestCrossLength: json['chest_cross_length'] as dynamic,
      armhole: json['armhole'] as int?,
      armStraightLength: json['arm_straight_length'] as dynamic,
      armCrossLength: json['arm_cross_length'] as dynamic,
      sleeveCrossLength: json['sleeve_cross_length'] as dynamic,
      bottomCrossLength: json['bottom_cross_length'] as dynamic,
      strap: json['strap'] as dynamic,
      totalEntryLength: json['total_entry_length'] as dynamic,
      waistCrossLength: json['waist_cross_length'] as dynamic,
      hipCrossLength: json['hip_cross_length'] as dynamic,
      bottomTopCrossLength: json['bottom_top_cross_length'] as dynamic,
      thighCrossLength: json['thigh_cross_length'] as dynamic,
      open: json['open'] as dynamic,
      lining: json['lining'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'size': size,
        'shoulder_cross_length': shoulderCrossLength,
        'chest_cross_length': chestCrossLength,
        'armhole': armhole,
        'arm_straight_length': armStraightLength,
        'arm_cross_length': armCrossLength,
        'sleeve_cross_length': sleeveCrossLength,
        'bottom_cross_length': bottomCrossLength,
        'strap': strap,
        'total_entry_length': totalEntryLength,
        'waist_cross_length': waistCrossLength,
        'hip_cross_length': hipCrossLength,
        'bottom_top_cross_length': bottomTopCrossLength,
        'thigh_cross_length': thighCrossLength,
        'open': open,
        'lining': lining,
      };
}
