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

  static showMenu(BuildContext context, String message, String? actionText,var isTrain) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            shadowColor: Colors.black,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              SizedBox.shrink(),
                Icon(Icons.cancel_rounded),
            ],),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
            content: SizedBox(
              // width: MediaQuery.of(context).size.height * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInAndSignUpScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          // border: const Border.fromBorderSide(
                          //   BorderSide(
                          //     width: 1,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurStyle: BlurStyle.outer,
                              spreadRadius: 2,
                              blurRadius: 5
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/maleAvatar.gif',
                              height: 50,
                              width: 50,
                            ),
                            const Text("My Profile",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            backgroundColor: isTrain ? Colors.lightBlueAccent : Colors.lightGreenAccent,
            // actions: [
            //   InkWell(
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //     child: Text(
            //       actionText!,
            //       style: const TextStyle(fontSize: 16),
            //     ),
            //   ),
            // ],
          );
        });
  }
}
