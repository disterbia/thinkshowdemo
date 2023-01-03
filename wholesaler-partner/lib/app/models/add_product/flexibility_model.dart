import '../../constant/enums.dart';

class FlexibilityModel {
  String name;
  FlexibilityType value;


  FlexibilityModel({
    required this.name,
    required this.value,
  });

  @override
  String toString() {
    return value.toString().split('.').last;
  }

}
