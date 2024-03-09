import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:public_transit_pass_info/config/mongoDB.dart';
import 'package:public_transit_pass_info/screens/NotificationScreen.dart';
import 'package:public_transit_pass_info/screens/SplashScreen.dart';
import 'package:public_transit_pass_info/screens/referralCode.dart';
import 'screens/HomeScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await MongoDatabase.connect();
  } catch (e) {
    if (kDebugMode) {
      print('Error connecting to MongoDB: $e');
    }
    return;
  }
  try {
    await Firebase.initializeApp();
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing Firebase: $e');
    }
  }
  return runApp(const PassApp());
}

class PassApp extends StatelessWidget{
  const PassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Public Transit Pass Information",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const SplashScreen(),
    );
  }
}
