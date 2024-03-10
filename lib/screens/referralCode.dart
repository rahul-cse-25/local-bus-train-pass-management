import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:public_transit_pass_info/config/constant.dart';
import 'package:share_plus/share_plus.dart';

import '../Provider/userProvider.dart';

class ReferralCodeScreen extends StatefulWidget {
  const ReferralCodeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ReferralCodeScreenState();
}

class _ReferralCodeScreenState extends State<ReferralCodeScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    bool isCopying = false;
    var referralCode = userProvider.userData.isNotEmpty
        ? userProvider.userData[0]['referralCode']
        : 'No referral code available';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Container(
          margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                width: double.infinity,
                // height: 100,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Referral Code",
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.black12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            referralCode,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const Expanded(
                            child: SizedBox.shrink(),
                          ),
                          IconButton(
                            onPressed: () {
                              // Implement the copy to clipboard functionality here
                              // You can use the Flutter Clipboard package
                              // For example:
                              Clipboard.setData(ClipboardData(
                                  text:
                                      ConstantServices.generateReferralCode()));

                              // Update the state to show the success icon
                              setState(() {
                                isCopying = true;
                              });
                              // Timer to reset the icon after 2 seconds
                              Timer(const Duration(seconds: 2), () {
                                setState(() {
                                  isCopying = false;
                                });
                              });
                            },
                            icon: isCopying
                                ? const Icon(
                                    Icons.check, // or any success icon
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.content_copy,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                              onTap: () {
                                // share link function calling
                                shareAppLinkWithReferralCode(referralCode);
                              },
                              child: const Icon(Icons.share)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const TextField(),
            ],
          ),
        ),
      ),
    );
  }

  void shareAppLinkWithReferralCode(var referralCode) {
    String message =
        "Check out the app that's changing the game! OvaDrive is not just an app, it's a revolution. Experience innovation at your fingertips and unlock a world of possibilities. $APP_LINK_OF_PLAYSTORE it also give you the reward if you join it by my referral code: *$referralCode*";
    Share.share(message);
  }
}
