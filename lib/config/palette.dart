import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class palette{
  static const formAnimeTime = Duration(milliseconds: 1000);
  static const formAnimation = Curves.easeOutBack;
  static const containerFormAnimation = Curves.easeOutBack;
  static const Color iconColor = Color(0xffc3c8d2);
  static const Color backGroundColor = Color(0xFFF3EEEE);
  static const Color uperContainerFirst = Color(0xff43a213);
  static const Color uperContainerSecond = Color(0xff0d46af);
  static const Color signUpSignInActive = Color(0xff1dbb04);
  static const Color signUpSignInDeactive = Color(0xff797474);
  static const Color textActiveColor = Color(0xff07085d);
  static const Color textDeactiveColor = Color(0xff797474);
  static const Color inputBorderDeactiveColor = Color(0xd8797474);
  static const Color inputBorderActiveColor = Color(0xad1c1a1a);
  static const Color iconSelected = Color(0xff06dc09);
  static const Color termConditions = Color(0xffff6a00);
  static const Color facebook = Color(0xff1877F2);
  static const Color google = Color(0xffDB4437);
  static const Color focusedIcon = Color(0xff06dc09);
  static const Color forgetButtonColor = Color(0xff0052ff);
  static const Color homeBackGroundColor =  Color(0xff0039b6);
  static const Color downNavColor =  Color(0x56565755);
  static Color trainThemeColor = Colors.blue.shade900;
  static Color busThemeColor = Colors.green.shade900;
  static Color trainComponantColor = Colors.blue.shade800;
  static Color busComponantColor = Colors.green.shade800;
  static Color profile1 = Colors.blue.shade100;
  static Color profile2 = Colors.green.shade100;
  static Color noticeCardColor = const Color(0xFF1DBB04);
  static LinearGradient noticAppBarColor = LinearGradient(colors: [busThemeColor,trainThemeColor],);
}