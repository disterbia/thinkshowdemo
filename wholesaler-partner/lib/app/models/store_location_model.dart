class StoreLocation {
  int? id;
  String? business_name;
  BuildingInfo? buildingInfo;
  FloorInfo? floorInfo;
  UnitInfo? unitInfo;

  StoreLocation({required this.id, required this.business_name, required this.buildingInfo, required this.floorInfo, required this.unitInfo});

  StoreLocation.fromJson(dynamic json) {
    id = json['id'];
    business_name = json['business_name'];
    buildingInfo = BuildingInfo.fromJson(json['buildingInfo']);
    floorInfo = FloorInfo.fromJson(json['floorInfo']);
    unitInfo = UnitInfo.fromJson(json['unitInfo']);
  }
}

class BuildingInfo {
  int? id;
  String? name;
  BuildingInfo({required this.id, required this.name});

  BuildingInfo.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}

class FloorInfo {
  int? id;
  String? name;
  FloorInfo({required this.id, required this.name});
  FloorInfo.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}

class UnitInfo {
  int? id;
  String? name;
  UnitInfo({required this.id, required this.name});
  UnitInfo.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}
