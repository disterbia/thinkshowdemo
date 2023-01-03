class Option {
  String? color;
  String? size;
  String? addPrice;

  Option({required this.color, required this.size, required this.addPrice});

  @override
  String toString() {
    return '{"color": "$color","size": "$size","add_price": $addPrice}';
  }

  Option.fromJson(dynamic json) {
    color = json['color'];
    size = json['size'];
    addPrice = json['add_price'].toString();
  }

  Map<String, dynamic> toJson() => {
        'color': color,
        'size': size,
        'add_price': addPrice,
      };
}
