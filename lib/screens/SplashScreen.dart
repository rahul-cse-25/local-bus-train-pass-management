
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'SignInAndSignUpScreen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

@override
void initState() {
    super.initState();
    Timer(const Duration(seconds: (3)),(){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const SignInAndSignUpScreen(),
  ));
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const Center(
          child: Text(
            "Pass Information",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 30),
          ),
        ),
      ),
    );
  }
}
