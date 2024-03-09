import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:public_transit_pass_info/config/constant.dart';

class MongoDatabase {

  static Future<List<Map<String, dynamic>>> fetchUserDetails(String email, String dbCollection) async {
    var db = await Db.create(MONGO_URL);
    await db.open();

    try {
      var collection = db.collection(dbCollection);
      var userQuery = {"email": email};
      var userData = await collection.findOne(userQuery);
      if (userData != null) {
        // Return user data as a list containing one user
        return [userData];
      } else {
        // Return an empty list if the user is not found
        return [];
      }
    } catch (error) {
      // Handle errors and return an empty list
      if (kDebugMode) {
        print(error.toString());
      }
      return [];
    } finally {
      await db.close();
    }
  }

  Future<String?> findReferralCodeByEmail(String email,String dbCollection ) async {

    final db = await Db.create(MONGO_URL);
    await db.open();
    final collection = db.collection(dbCollection);
    final result = await collection.findOne(where.eq('email', email));
    await db.close();

    if (result != null && result.containsKey('referralCode')) {
      return result['referralCode'] as String?;
    } else {
      return null; // Return null if the email or referralCode is not found
    }
  }

  static Future<dynamic> saveUserData(Map<String, dynamic> userData,var dbCollection) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    try{
      var collection = db.collection(dbCollection);
      await collection.insert(userData);
      return userData['email'].toString();
    }catch(ex){
      if (kDebugMode) {
        print(ex.toString());
      }
    }finally{
    await db.close();
  }
  }

  static Future<void> deleteUserData(Map<String, dynamic> userData,var dbCollection) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(dbCollection);
    await collection.deleteOne(userData);
    db.close();
  }

  static Future<void> updateUserData(Map<String, dynamic> selector, Map<String, dynamic> modifier, var dbCollection) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(dbCollection);
    await collection.update(selector, modifier);
    db.close();
  }




  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    // inspect(db);
    // var status = db.serverStatus();
    // if (kDebugMode) {
    //   print(status);
    // }
    // var collection = db.collection(USER_DETAILS_COLLECTION);
    // if (kDebugMode) {
    //   print(await collection.find().toList());
    // }
  }
}


// to update call the function like this
// Map<String, dynamic> selector = {"username": "existingUsername"};
// Map<String, dynamic> modifier = {
//   "\$set": {"name": "newName", "email": "newEmail@gmail.com"}
// };
// await MongoDatabase.updateUserData(selector, modifier, "yourCollectionName");
