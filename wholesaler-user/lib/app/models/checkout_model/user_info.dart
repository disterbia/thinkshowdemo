import 'package:get/get.dart';

import 'address_info.dart';

class UserInfo {
  String? name;
  String? phone;
  String? email;
  RxInt point;
  AddressInfo? addressInfo;

  UserInfo({
    this.name,
    this.phone,
    this.email,
    required this.point,
    this.addressInfo,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        point: (json['point'] as int).obs,
        addressInfo: json['address_info'] == null ? null : AddressInfo.fromJson(json['address_info'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'point': point,
        'address_info': addressInfo?.toJson(),
      };
}
