import 'dart:convert';

class AdTab2ApplyModel {
  int? id;
  String? title;
  String? content;
  String? targetMonthInfo;
  String? target_month_start_date;
  int? cost;
  int? advertisementTypeCode;
  String? advertisementTypeName;
  List<String>? notApplicableDateList;

  AdTab2ApplyModel({
    this.id,
    this.title,
    this.content,
    this.targetMonthInfo,
    this.cost,
    this.advertisementTypeCode,
    this.advertisementTypeName,
    this.notApplicableDateList,
    this.target_month_start_date,
  });

  factory AdTab2ApplyModel.fromMap(Map<String, dynamic> data) {
    List<String>? tempNotApplicableDate = [];
    for (var item in data['not_applicable_date_list']) {
      tempNotApplicableDate.add(item.toString());
    }
    return AdTab2ApplyModel(
      id: data['id'] as int?,
      title: data['title'] as String?,
      content: data['content'] as String?,
      targetMonthInfo: data['target_month_info'] as String?,
      target_month_start_date: data['target_month_start_date'] as String?,
      cost: data['cost'] as int?,
      advertisementTypeCode: data['advertisement_type_code'] as int?,
      advertisementTypeName: data['advertisement_type_name'] as String?,
      notApplicableDateList: tempNotApplicableDate,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'target_month_info': targetMonthInfo,
        'cost': cost,
        'advertisement_type_code': advertisementTypeCode,
        'advertisement_type_name': advertisementTypeName,
        'not_applicable_date_list': notApplicableDateList,
        'target_month_start_date': target_month_start_date,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AdTab2ApplyModel].
  factory AdTab2ApplyModel.fromJson(String data) {
    return AdTab2ApplyModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AdTab2ApplyModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
