import 'dart:convert';

import 'application_list.dart';

class HistoryAdModel {
  int? amountToBePaid;
  int? amountCompletePaid;
  List<ApplicationList>? applicationList;

  HistoryAdModel({
    this.amountToBePaid,
    this.amountCompletePaid,
    this.applicationList,
  });

  factory HistoryAdModel.fromMap(Map<String, dynamic> data) {
    return HistoryAdModel(
      amountToBePaid: data['amount_to_be_paid'] as int?,
      amountCompletePaid: data['amount_complete_paid'] as int?,
      applicationList: (data['application_list'] as List<dynamic>?)?.map((e) => ApplicationList.fromMap(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'amount_to_be_paid': amountToBePaid,
        'amount_complete_paid': amountCompletePaid,
        'application_list': applicationList?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HistoryAdModel].
  factory HistoryAdModel.fromJson(String data) {
    return HistoryAdModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HistoryAdModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
