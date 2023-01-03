class PointMgmtPageModel {
	int? id;
	int? point;
	String? content;
	String? createdAt;

	PointMgmtPageModel({this.id, this.point, this.content, this.createdAt});

	factory PointMgmtPageModel.fromJson(Map<String, dynamic> json) {
		return PointMgmtPageModel(
			id: json['id'] as int?,
			point: json['point'] as int?,
			content: json['content'] as String?,
			createdAt: json['created_at'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'id': id,
				'point': point,
				'content': content,
				'created_at': createdAt,
			};
}
