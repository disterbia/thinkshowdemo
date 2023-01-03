import 'package:get/state_manager.dart';
import 'package:wholesaler_user/app/models/address_model.dart';

class User {
  String userID;
  String userName;
  String? phoneNumber;
  String? email;
  Address? address;
  DateTime? birthday;
  RxInt? points;
  int? waitingReviewCount;
  RxBool? isAgreeNotificaiton;

  User({
    required this.userID,
    required this.userName,
    this.phoneNumber,
    this.address,
    this.birthday,
    this.points,
    this.waitingReviewCount,
    this.isAgreeNotificaiton,
    this.email,
  });

  /// Order
  static User dummy1() {
    return User(
      userID: 'seunghan',
      userName: 'seunghan',
      phoneNumber: '01025081486',
      address: Address.dummy(),
      birthday: DateTime.now(),
      points: 1000.obs,
    );
  }

  /// Product Detail
  static User dummy2() {
    return User(
      userID: 'seunghan',
      userName: 'seunghan',
    );
  }
}
