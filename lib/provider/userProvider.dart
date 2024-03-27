import 'package:flutter/cupertino.dart';

import '../config/constant.dart';
import '../config/mongoDB.dart';

class UserProvider extends ChangeNotifier {

  final MongoDatabase dbServices = MongoDatabase();

  static String? _userId; // In this app, it will be an email
  late List<Map<String, dynamic>> _userData; // All user's related data
  late List<Map<String,dynamic>> _userPassDetails;
  String? get userId => _userId;

  List<Map<String, dynamic>> get userData => _userData; // Corrected getter
  List<Map<String, dynamic>> get userPassDetails => _userPassDetails; // Corrected getter

  // void setUserPassDetails()async{
  //   _userPassDetails =
  //   await dbServices.getPassDetails();
  // }


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
