import 'dart:convert';

import 'application_detail_list.dart';

class ApplicationList {
	int? advertisementCode;
	String? advertisementName;
	List<ApplicationDetailList>? applicationDetailList;

	ApplicationList({
		this.advertisementCode, 
		this.advertisementName, 
		this.applicationDetailList, 
	});

	factory ApplicationList.fromMap(Map<String, dynamic> data) {
		return ApplicationList(
			advertisementCode: data['advertisement_code'] as int?,
			advertisementName: data['advertisement_name'] as String?,
			applicationDetailList: (data['application_detail_list'] as List<dynamic>?)
						?.map((e) => ApplicationDetailList.fromMap(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toMap() => {
				'advertisement_code': advertisementCode,
				'advertisement_name': advertisementName,
				'application_detail_list': applicationDetailList?.map((e) => e.toMap()).toList(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ApplicationList].
	factory ApplicationList.fromJson(String data) {
		return ApplicationList.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [ApplicationList] to a JSON string.
	String toJson() => json.encode(toMap());
}
