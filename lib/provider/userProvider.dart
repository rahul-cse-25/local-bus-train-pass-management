import 'package:flutter/cupertino.dart';

import '../config/constant.dart';
import '../config/mongoDB.dart';

class UserProvider extends ChangeNotifier {
  static String? _userId; // In this app, it will be an email
  late List<Map<String, dynamic>> _userData; // All user's related data

  String? get userId => _userId;

  List<Map<String, dynamic>> get userData => _userData; // Corrected getter

  void setUserId(String? userId) {
    _userId = userId;
    setUserData();
    print(
        'UserIDinUserProvider:*****************************************$_userId');
    notifyListeners();
  }

  Future<void> setUserData() async {
    _userData =
        await MongoDatabase.fetchUserDetails(userId!, USER_DETAILS_COLLECTION);
    print(
        'UserDATAinUserProvider:*****************************************$_userData');
    notifyListeners();
  }
}
