import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_user/app/constants/variables.dart';

String _tokenKey = MyVars.isUserProject() ? 'token_user' : 'token_partner';
String _fcmTokenKey =
    MyVars.isUserProject() ? 'fcm_token_user' : 'fcm_token_partner';
const _isOwnerKey = 'isOwner';
const _isPrivilegeKey = 'isPrivilege';
const _userIDKey = 'userID';
const _recentProductKey = 'recentProduct2';

class CacheProvider {
  CacheProvider._internal();

  final data = GetStorage();

  static final CacheProvider _singleton = CacheProvider._internal();

  factory CacheProvider() {
    return _singleton;
  }

  // JWT TOKEN
  void setToken(String token) {
    data.write(_tokenKey, token);
  }

  void logOut() {}

  void removeToken() {
   // print("제거됨");
    data.write(_tokenKey, '');
  }

  String getToken() {
  //  print("token:${data.read(_tokenKey)}");
    return data.read(_tokenKey) ?? '';
  }

  // Firebase FCM TOKEN
  void setFCMToken(String token) {
    data.write(_fcmTokenKey, token);
  }

  void removeFCMToken() {
    data.write(_fcmTokenKey, '');
  }

  String getFCMToken() {
    return data.read(_fcmTokenKey) ?? '';
  }

  // USER ID
  void setUserID(String userID) {
    data.write(_userIDKey, userID);
  }

  String getUserID() {
    return data.read(_userIDKey) ?? '';
  }

  void removeUserId() {
    data.remove(_userIDKey);
  }

  // STORE CEO / STAFF
  void setOwner(bool isOwner) {
    data.write(_isOwnerKey, isOwner);
  }

  bool isOwner() {
    return data.read(_isOwnerKey) ?? false;
  }

  void removeOwner() {
    data.write(_isOwnerKey, null);
  }

  /// setPrivilege is used for Dingdong
  void setPrivilege(bool isPrivilege) {
    data.write(_isPrivilegeKey, isPrivilege);
  }

  /// isPrivilege is used for Dingdong
  bool isPrivilege() {
    return data.read(_isPrivilegeKey) ?? false;
  }

  void removePrivilege() {
    data.write(_isPrivilegeKey, null);
  }

  // Recently Viewed Products
  void addRecentlyViewedProduct(int productId) {
    List<int> productIds = getAllRecentlyViewedProducts();
    if (productIds.length > 27) {
      productIds.removeLast();
    }
    if (productIds.contains(productId)) {
      productIds.remove(productId);
    }
    productIds.insert(
        0, productId); // add the productId to the beginning of array
    data.write(_recentProductKey, productIds);
  }

  List<int> getAllRecentlyViewedProducts() {
    print('data.read(_recentProductKey) ${data.read(_recentProductKey)}');
    List<int> productIds = [];
    if (data.read(_recentProductKey) != null) {
      for (var productid in data.read(_recentProductKey)) {
        productIds.add(productid);
      }
    }

    return productIds;
  }

  void removeRecentlyViewedProduct() {
    data.write(_recentProductKey, null);
  }
}
