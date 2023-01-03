class ProductClothCaringGuide {
	bool? isHandWash;
	bool? isDryCleaning;
	bool? isWaterWash;
	bool? isSingleWash;
	bool? isWoolWash;
	bool? isNotBleash;
	bool? isNotIroning;
	bool? isNotMachineWash;

	ProductClothCaringGuide({
		this.isHandWash, 
		this.isDryCleaning, 
		this.isWaterWash, 
		this.isSingleWash, 
		this.isWoolWash, 
		this.isNotBleash, 
		this.isNotIroning, 
		this.isNotMachineWash, 
	});

	factory ProductClothCaringGuide.fromJson(Map<String, dynamic> json) {
		return ProductClothCaringGuide(
			isHandWash: json['is_hand_wash'] as bool?,
			isDryCleaning: json['is_dry_cleaning'] as bool?,
			isWaterWash: json['is_water_wash'] as bool?,
			isSingleWash: json['is_single_wash'] as bool?,
			isWoolWash: json['is_wool_wash'] as bool?,
			isNotBleash: json['is_not_bleash'] as bool?,
			isNotIroning: json['is_not_ironing'] as bool?,
			isNotMachineWash: json['is_not_machine_wash'] as bool?,
		);
	}



	Map<String, dynamic> toJson() => {
				'is_hand_wash': isHandWash,
				'is_dry_cleaning': isDryCleaning,
				'is_water_wash': isWaterWash,
				'is_single_wash': isSingleWash,
				'is_wool_wash': isWoolWash,
				'is_not_bleash': isNotBleash,
				'is_not_ironing': isNotIroning,
				'is_not_machine_wash': isNotMachineWash,
			};
}
