class Address {
  String address; // 주소 1
  String addressDetail; // 주소 2
  String addressType; // R = 도로명, J = 지변
  String zipCode;
  String requestMessage; // 요청사항
  Address({
    required this.address,
    required this.addressDetail,
    required this.addressType,
    required this.zipCode,
    required this.requestMessage,
  });

  static Address dummy() {
    return Address(
      address: '서울특별시 강남구 도곡로 170(도곡동)',
      addressDetail: '대성빌딩 300호',
      addressType: 'R',
      zipCode: '02347',
      requestMessage: '문 앞에 넣어주세요.',
    );
  }
}
