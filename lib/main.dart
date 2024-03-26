import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_transit_pass_info/config/mongoDB.dart';
import 'package:public_transit_pass_info/screens/NotificationScreen.dart';
import 'package:public_transit_pass_info/screens/SignInAndSignUpScreen.dart';
import 'package:public_transit_pass_info/screens/SplashScreen.dart';
import 'package:public_transit_pass_info/screens/referralCode.dart';
import 'package:public_transit_pass_info/services/authServices.dart';
import 'Provider/userProvider.dart';
import 'screens/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await MongoDatabase.connect();
  } catch (e) {
    if (kDebugMode) {
      print(
          "*********************************************************************************************");
      print('Error connecting to MongoDB: $e');
      print(
          "*********************************************************************************************");
    }
    return;
  }
  try {
    await Firebase.initializeApp();
  } catch (e) {
    if (kDebugMode) {
      print(
          "*********************************************************************************************");
      print('Error initializing Firebase: $e');
      print(
          "*********************************************************************************************");
    }
  }
  runApp(
    MultiProvider(providers: [
      // Add other Providers
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ], child: const PassApp()),
  );
}

class PassApp extends StatelessWidget {
  const PassApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Public Transit Pass Information",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInAndSignUpScreen(),
    );
  }
}
