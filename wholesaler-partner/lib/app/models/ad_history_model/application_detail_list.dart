import 'dart:convert';

class ApplicationDetailList {
  int? id;
  String? applicationDate;
  bool? isComplete;
  int? cost;
  bool? is_real_time_cost;
  int? budget_setting_amount;

  ApplicationDetailList({
    this.id,
    this.applicationDate,
    this.isComplete,
    this.cost,
    this.is_real_time_cost,
    this.budget_setting_amount
  });

  factory ApplicationDetailList.fromMap(Map<String, dynamic> data) {
    return ApplicationDetailList(
      id: data['id'] as int?,
      applicationDate: data['application_date'] as String?,
      isComplete: data['is_complete'] as bool?,
      cost: data['cost'] as int?,
      is_real_time_cost: data['is_real_time_cost'] as bool?,
      budget_setting_amount: data['budget_setting_amount'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'application_date': applicationDate,
        'is_complete': isComplete,
        'cost': cost,
        'is_real_time_cost': is_real_time_cost,
         'budget_setting_amount': budget_setting_amount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ApplicationDetailList].
  factory ApplicationDetailList.fromJson(String data) {
    return ApplicationDetailList.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ApplicationDetailList] to a JSON string.
  String toJson() => json.encode(toMap());
}
