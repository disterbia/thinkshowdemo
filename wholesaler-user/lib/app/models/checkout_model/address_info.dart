class AddressInfo {
	String? zipCode;
	String? address;
	String? addressDetail;

	AddressInfo({this.zipCode, this.address, this.addressDetail});

	factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
				zipCode: json['zip_code'] as String?,
				address: json['address'] as String?,
				addressDetail: json['address_detail'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'zip_code': zipCode,
				'address': address,
				'address_detail': addressDetail,
			};
}
