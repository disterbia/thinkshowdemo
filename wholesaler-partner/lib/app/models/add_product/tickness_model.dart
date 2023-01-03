import '../../constant/enums.dart';

class ThicknessModel {
  String name;
  ThicknessType value;


  ThicknessModel({
    required this.name,
    required this.value,
  });

  @override
  String toString() {
    return value.toString().split('.').last;
  }

}
