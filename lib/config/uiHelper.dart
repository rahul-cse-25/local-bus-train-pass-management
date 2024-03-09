import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:public_transit_pass_info/config/palette.dart';
import 'package:public_transit_pass_info/screens/SignInAndSignUpScreen.dart';

class UiHelper {
  static customDialog(
      BuildContext context, String message, String? actionText) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: Colors.black,
            title: Text(
              message,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black), // Change color here
            ),
            backgroundColor: Colors.white,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  actionText!,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        });
  }
}
