class ResponseSignUpSeo {
  ResponseSignUpSeo({
      this.status, 
      this.title, 
      this.description, 
      this.logIndex, 
      this.validationErrors,});

  ResponseSignUpSeo.fromJson(dynamic json) {
    status = json['status'];
    title = json['title'];
    description = json['description'];
    logIndex = json['log_index'];
    validationErrors = json['validation_errors'] != null ? ValidationErrors.fromJson(json['validation_errors']) : null;
  }
  int? status;
  String? title;
  String? description;
  String? logIndex;
  ValidationErrors? validationErrors;
ResponseSignUpSeo copyWith({  int? status,
  String? title,
  String? description,
  String? logIndex,
  ValidationErrors? validationErrors,
}) => ResponseSignUpSeo(  status: status ?? this.status,
  title: title ?? this.title,
  description: description ?? this.description,
  logIndex: logIndex ?? this.logIndex,
  validationErrors: validationErrors ?? this.validationErrors,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['title'] = title;
    map['description'] = description;
    map['log_index'] = logIndex;
    if (validationErrors != null) {
      map['validation_errors'] = validationErrors?.toJson();
    }
    return map;
  }

}

class ValidationErrors {
  ValidationErrors({
      this.password,});

  ValidationErrors.fromJson(dynamic json) {
    password = json['password'] != null ? json['password'].cast<String>() : [];
  }
  List<String>? password;
ValidationErrors copyWith({  List<String>? password,
}) => ValidationErrors(  password: password ?? this.password,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['password'] = password;
    return map;
  }

}