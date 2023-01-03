class MaterialList {
	String? name;
	int? ratio;

	MaterialList({this.name, this.ratio});

	factory MaterialList.fromJson(Map<String, dynamic> json) => MaterialList(
				name: json['name'] as String?,
				ratio: json['ratio'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'name': name,
				'ratio': ratio,
			};
}
