class BulletinModel {
  BulletinModel({
      this.id, 
      this.title, 
      this.createdAt,});

  BulletinModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
  }
  int? id;
  String? title;
  String? createdAt;
BulletinModel copyWith({  int? id,
  String? title,
  String? createdAt,
}) => BulletinModel(  id: id ?? this.id,
  title: title ?? this.title,
  createdAt: createdAt ?? this.createdAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['created_at'] = createdAt;
    return map;
  }

}