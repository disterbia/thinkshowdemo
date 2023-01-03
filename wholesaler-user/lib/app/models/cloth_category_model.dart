class ClothCategoryModel {
  int id;
  String name;
  int? parentId;
  int depth;
  bool isUse;
  ClothCategoryModel({
    required this.id,
    required this.name,
    required this.parentId,
    required this.depth,
    required this.isUse,
  });
}
