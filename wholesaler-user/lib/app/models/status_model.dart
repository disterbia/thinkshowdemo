class StatusModel {
  String message;
  int statusCode;
  String? data;


  StatusModel({
    required this.message,
    required this.statusCode,
    this.data,
  });

}
