import '../../constant/enums.dart';

class SeeThroughModel {
  String name;
  SeeThroughType value;


  SeeThroughModel({
    required this.name,
    required this.value,
  });

  @override
  String toString() {
    return value.toString().split('.').last;
  }

}
