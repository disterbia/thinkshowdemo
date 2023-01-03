import 'package:get/state_manager.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';

class Address {
  int? id;
  int? parent_id;
  BuildingType? type;
  RxString? name;
  bool? is_entering_store;
  String? business_name;
  int? store_id;

  Address({
    required this.id,
    this.parent_id,
    required this.type,
    required this.name,
    this.is_entering_store,
    this.business_name,
    this.store_id,
  });

  Address.empty()
      : this(
          id: 0,
          type: BuildingType.building,
          name: 'EMPTY'.obs,
        );

  Address.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    parent_id = map['parent_id'];
    type = map['type'] == 'building' ? BuildingType.building : BuildingType.floor;
    name = (map['name'] as String).obs;
    is_entering_store = map['is_entering_store'];
    business_name = map['business_name'];
    store_id = map['store_id'];
  }
}
