import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:public_transit_pass_info/config/palette.dart';
import 'package:public_transit_pass_info/screens/referralCode.dart';
import '../config/constant.dart';
import '../config/mongoDB.dart';
import '../config/notificatoinServices.dart';
import 'NotificationScreen.dart';

class HomeScreen extends StatefulWidget {
  final userId;

  const HomeScreen({super.key, required this.userId});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool isTrain = true;
  late var userId;
  late List<Map<String, dynamic>> userData = [];
  TextEditingController searchText = TextEditingController();
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    userId = widget.userId.toString();
    if (kDebugMode) {
      print("****************************************");
      getUserData();
      print("UserInHomeID: $userId");
      print("****************************************");
    }
    notificationServices.requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double verticalInternalPadding =
        isLandScape ? screenSize.height * 0.03 : screenSize.height * 0.03;
    double horizontalcalInternalPadding =
        isLandScape ? screenSize.width * 0.02 : screenSize.width * 0.05;
    double componentContainerSize =
        isLandScape ? screenSize.width * 0.15 : screenSize.width * 0.25;

    return Scaffold(
      backgroundColor:
          isTrain ? palette.trainThemeColor : palette.busThemeColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(horizontalcalInternalPadding * 0.8),
            child: Column(
              children: [
                // Intro and Notification with Menu Icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Hello, ${userData.isNotEmpty ? userData[0]['username'] : ''}",
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                        const Text(
                          "20 Sept, 2024",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isTrain
                                ? palette.trainComponantColor
                                : palette.busComponantColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationScreen()));
                                if (kDebugMode) {
                                  print('Notice');
                                }
                              },
                              child: const Icon(
                                Icons.notifications,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(
                          width: horizontalcalInternalPadding,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isTrain
                                ? palette.trainComponantColor
                                : palette.busComponantColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  isTrain = !isTrain;
                                });
                                if (kDebugMode) {
                                  print('Menu');
                                }
                              },
                              child: const Icon(
                                Icons.menu,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: horizontalcalInternalPadding,
                ),
                // Search Bar
                Container(
                  width: screenSize.width,
                  height: isLandScape
                      ? screenSize.height / 8
                      : screenSize.height / 18,
                  decoration: BoxDecoration(
                    color: isTrain
                        ? palette.trainComponantColor
                        : palette.busComponantColor,
                    borderRadius: BorderRadius.circular(12),
                    border: const Border.fromBorderSide(
                        BorderSide(color: Colors.white30)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: horizontalcalInternalPadding / 2,
                      ),
                      Icon(
                        Icons.search,
                        size: isLandScape
                            ? screenSize.width * 0.035
                            : screenSize.width * 0.08,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: horizontalcalInternalPadding / 2,
                      ),
                      Expanded(
                          child: TextField(
                        controller: searchText,
                        cursorColor: isTrain
                            ? palette.trainThemeColor
                            : palette.busThemeColor,
                        cursorOpacityAnimates: true,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          hintText: "Search...",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                          border: InputBorder.none,
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: horizontalcalInternalPadding,
                ),
                // Train and Bus Pass Data Presentation
                Container(
                  width: screenSize.width,
                  height: isLandScape
                      ? screenSize.height * 0.50
                      : screenSize.height * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    // image: DecorationImage(
                    //     image: AssetImage(isTrain
                    //         ? 'assets/images/trainLogo.png'
                    //         : 'assets/images/busLogo.png'),
                    //     // Replace with your image path
                    //     fit: BoxFit.contain,
                    //     opacity: 0.1 // Adjust how the image fits the container
                    //     ),
                  ),
                  // child: Lottie.asset(
                  //   'assets/animation/train.json',
                  //   fit: BoxFit.fill,
                  //   repeat: true,
                  //   reverse: true
                  // ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        height: screenSize.height * 0.06,
                        color: Colors.deepOrange.shade400,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              isTrain
                                  ? "Mumbai Local Train"
                                  : "Mumbai Local Bus",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900),
                            ),
                            Image.asset(
                              isTrain
                                  ? 'assets/images/trainLogo.png'
                                  : 'assets/images/busLogo.png',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: RichText(
                            text: const TextSpan(
                                text: "Name: ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                children: [
                              TextSpan(
                                  text: "Rahul Prajapati",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ])),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: const TextSpan(
                                    text: "From: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                    children: [
                                  TextSpan(
                                      text: "Vasai Road",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ])),
                            RichText(
                                text: const TextSpan(
                                    text: "To: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                    children: [
                                  TextSpan(
                                      text: "Virar",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ])),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: RichText(
                            text: const TextSpan(
                                text: "Class: ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                children: [
                              TextSpan(
                                  text: "Second",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: RichText(
                            text: const TextSpan(
                                text: "Valid from: ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                children: [
                              TextSpan(
                                  text: "31-01-2024",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "  To  ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              TextSpan(
                                  text: "30-04-2024",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ])),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: horizontalcalInternalPadding,
                ),
                // Cards in row
                SizedBox(
                  width: screenSize.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: componentContainerSize,
                          height: componentContainerSize,
                          padding: EdgeInsets.all(verticalInternalPadding / 2),
                          margin: EdgeInsets.only(
                              right: isLandScape
                                  ? horizontalcalInternalPadding * 2
                                  : horizontalcalInternalPadding / 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isTrain
                                  ? palette.trainComponantColor
                                  : palette.busComponantColor),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ReferralCodeScreen()));
                            },
                            child: Image.asset(
                              isTrain
                                  ? 'assets/images/trainTicket.png'
                                  : 'assets/images/busTicket.png',
                            ),
                          ),
                        ),
                        Container(
                          width: componentContainerSize,
                          height: componentContainerSize,
                          padding: EdgeInsets.all(verticalInternalPadding / 2),
                          margin: EdgeInsets.only(
                              right: isLandScape
                                  ? horizontalcalInternalPadding * 2
                                  : horizontalcalInternalPadding / 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isTrain
                                  ? palette.trainComponantColor
                                  : palette.busComponantColor),
                          child: InkWell(
                            onTap: () {},
                            child: Image.asset(
                              isTrain
                                  ? 'assets/images/trainPass.png'
                                  : 'assets/images/busPass.png',
                            ),
                          ),
                        ),
                        Container(
                          width: componentContainerSize,
                          height: componentContainerSize,
                          padding: EdgeInsets.all(verticalInternalPadding / 2),
                          margin: EdgeInsets.only(
                              right: isLandScape
                                  ? horizontalcalInternalPadding * 2
                                  : horizontalcalInternalPadding / 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isTrain
                                  ? palette.trainComponantColor
                                  : palette.busComponantColor),
                          child: InkWell(
                            onTap: () {},
                            child: Image.asset(
                              isTrain
                                  ? 'assets/images/trainTicket.png'
                                  : 'assets/images/busTicket.png',
                            ),
                          ),
                        ),
                        Container(
                          width: componentContainerSize,
                          height: componentContainerSize,
                          padding: EdgeInsets.all(verticalInternalPadding / 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isTrain
                                  ? palette.trainComponantColor
                                  : palette.busComponantColor),
                          child: InkWell(
                            onTap: () {},
                            child: Image.asset(
                              isTrain
                                  ? 'assets/images/trainPass.png'
                                  : 'assets/images/busPass.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: horizontalcalInternalPadding,
                ),
                // QR container
                Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.4,
                  padding: EdgeInsets.all(horizontalcalInternalPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: isTrain ? palette.trainComponantColor : palette.busComponantColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white30,
                          blurRadius: 20,
                          spreadRadius: 2)
                    ],
                  ),
                  child: Center(
                    child: Image.asset('assets/images/busPass.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   width: screenSize.width,
      //   height:isLandScape ? screenSize.height * 0.16: screenSize.height * 0.08,
      //   decoration:
      //       const BoxDecoration(color: palette.textDeactiveColor, boxShadow: [
      //     BoxShadow(
      //       color: Colors.white,
      //       blurRadius: 1,
      //       spreadRadius: 1,
      //     )
      //   ]),
      // ),
    );
  }

  Future<void> getUserData() async {
    userData =
        await MongoDatabase.fetchUserDetails(userId, USER_DETAILS_COLLECTION);
    setState(() {});
    if (kDebugMode) {
      print(
          "*********************************************************************");
      print('User Data: $userData');
      print(
          "*********************************************************************");
    }
  }
}
