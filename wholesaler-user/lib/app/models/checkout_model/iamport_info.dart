class IamportInfo {
  String? pg;
  String? iamportId;
  int? merchantUid;

  IamportInfo({this.pg, this.iamportId, this.merchantUid});

  factory IamportInfo.fromJson(Map<String, dynamic> json) => IamportInfo(
        pg: json['pg'] as String?,
        iamportId: json['iamport_id'] as String?,
        merchantUid: json['merchant_uid'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'pg': pg,
        'iamport_id': iamportId,
        'merchant_uid': merchantUid,
      };
}
