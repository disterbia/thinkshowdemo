class StaffModel {
  StaffModel({
      this.id, 
      this.name, 
      this.status,});

  StaffModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }
  int? id;
  String? name;
  String? status;
StaffModel copyWith({  int? id,
  String? name,
  String? status,
}) => StaffModel(  id: id ?? this.id,
  name: name ?? this.name,
  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['status'] = status;
    return map;
  }

}