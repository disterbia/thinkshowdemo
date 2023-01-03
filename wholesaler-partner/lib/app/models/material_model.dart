class MaterialModel {
  String name;
  String percent;

  MaterialModel({
    required this.name,
    required this.percent,
  });

  @override
  String toString() {
    return '{"name": "$name", "ratio": $percent}';
  }
}
