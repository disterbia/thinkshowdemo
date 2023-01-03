import 'dart:math';

class ProductTitles {
  /// Product Title Builder
  static String dummy() {
    List<String> titles = [
      '여성 오버핏',
      '반팔반팔티',
      '후드',
      '아재방 자전거 어반 헬멧',
      '고스트리퍼블릭 남성용 에어쿨링 트임',
      '나이키 스우시 컴포트핏 이너컬러',
      '모이브닝 왕대두 볼캡',
      '바니브라운 55 솔리드 곡자 장우산',
      'Examen 수능시계 큰숫자 저소음',
    ];
    return titles[Random().nextInt(titles.length)];
  }
}
