import 'advertisement_card_info.dart';

class AdOrderModel {
	int? id;
	String? imageUrl;
	int? cost;
	AdvertisementCardInfo? advertisementCardInfo;
	int? advertisementTypeCode;
	String? advertisementTypeName;
	String? guideText;

	AdOrderModel({
		this.id, 
		this.imageUrl, 
		this.cost, 
		this.advertisementCardInfo, 
		this.advertisementTypeCode, 
		this.advertisementTypeName, 
		this.guideText, 
	});

	factory AdOrderModel.fromJson(Map<String, dynamic> json) => AdOrderModel(
				id: json['id'] as int?,
				imageUrl: json['image_url'] as String?,
				cost: json['cost'] as int?,
				advertisementCardInfo: json['advertisement_card_info'] == null
						? null
						: AdvertisementCardInfo.fromJson(json['advertisement_card_info'] as Map<String, dynamic>),
				advertisementTypeCode: json['advertisement_type_code'] as int?,
				advertisementTypeName: json['advertisement_type_name'] as String?,
				guideText: json['guide_text'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'image_url': imageUrl,
				'cost': cost,
				'advertisement_card_info': advertisementCardInfo?.toJson(),
				'advertisement_type_code': advertisementTypeCode,
				'advertisement_type_name': advertisementTypeName,
				'guide_text': guideText,
			};
}
