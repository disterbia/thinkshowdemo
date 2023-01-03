class ModelInfo {
	dynamic height;
	dynamic modelWeight;
	dynamic modelSize;

	ModelInfo({this.height, this.modelWeight, this.modelSize});

	factory ModelInfo.fromJson(Map<String, dynamic> json) => ModelInfo(
				height: json['height'] as dynamic,
				modelWeight: json['model_weight'] as dynamic,
				modelSize: json['model_size'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'height': height,
				'model_weight': modelWeight,
				'model_size': modelSize,
			};
}
