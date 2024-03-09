import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:public_transit_pass_info/config/notificatoinServices.dart';
import 'package:public_transit_pass_info/config/palette.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  NotificationServices notificationServices = NotificationServices();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.isTokenRefreshed();
    notificationServices.getDeviceToken().then((value){
      if (kDebugMode) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        print("Device Token : $value");
        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: palette.iconColor,
        appBar: AppBar(
          backgroundColor: const Color(0xff236e2a),
          title: const Text("Notifications"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Notification head",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "This is the body or content of notification message",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        Text(
                          _getFormattedTimestamp(),
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _getFormattedTimestamp() {
    DateTime now = DateTime.now();
    return "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}";
  }
}
