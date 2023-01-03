class AdvertisementCardInfo {
	String? title;
	String? content;
	String? addInfo;

	AdvertisementCardInfo({this.title, this.content, this.addInfo});

	factory AdvertisementCardInfo.fromJson(Map<String, dynamic> json) {
		return AdvertisementCardInfo(
			title: json['title'] as String?,
			content: json['content'] as String?,
			addInfo: json['add_info'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'title': title,
				'content': content,
				'add_info': addInfo,
			};
}
