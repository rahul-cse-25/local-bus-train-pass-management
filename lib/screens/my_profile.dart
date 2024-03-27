import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../config/mongoDB.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final MongoDatabase dbServices = MongoDatabase();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController aadharNum = TextEditingController();
  TextEditingController userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var isTablet = screenSize.width > 600 && screenSize.height > 600;

    return Scaffold(
      // backgroundColor: backgroundColour,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                width: screenSize.width,
                height: screenSize.height * 0.4,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      Colors.deepPurpleAccent,
                      Colors.purple,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: screenSize.width * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(screenSize.width * 0.015),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      Colors.deepPurpleAccent,
                      Colors.purple,
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.06,
            left:
                (screenSize.width - MediaQuery.of(context).size.width * 0.35) /
                    2, // Centering the container horizontally
            child: GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(MediaQuery.of(context).size.width),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      Colors.deepPurpleAccent,
                      Colors.purple,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.36,
            left: 0,
            right: 0,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
              child: SizedBox(
                height: screenSize.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      buildTextFields(Icons.verified_user_outlined,
                          "Enter Username", 4, screenSize),
                      Row(
                        children: [
                          Expanded(
                            child: buildTextFields(
                                Icons.person, "First Name", 0, screenSize),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.03,
                          ),
                          Expanded(
                            child: buildTextFields(
                                Icons.person, "Last Name", 1, screenSize),
                          ),
                        ],
                      ),
                      buildTextFields(
                          Icons.numbers, "Contact Number", 2, screenSize),
                      buildTextFields(Icons.credit_card, "Enter aadhar Number",
                          3, screenSize),
                      ElevatedButton(
                          style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blueAccent),
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                            ),
                            elevation: MaterialStatePropertyAll(12),
                          ),
                          onPressed: () async {
                            if (kDebugMode) {
                              print(
                                  "*******************************************");
                              print("FirstName: ${firstName.text.toString()}");
                              print("LastName: ${lastName.text.toString()}");
                              print(
                                  "ContactName: ${contactNumber.text.toString()}");
                              print(
                                  "Aadhaar Number: ${aadharNum.text.toString()}");
                              print("UserName: ${userName.text.toString()}");
                              print(
                                  "*******************************************");
                            }
                            User? user = FirebaseAuth.instance.currentUser;
                            await dbServices.updateUserData(
                                user!.uid,
                                userName.text.toString(),
                                firstName.text.toString(),
                                lastName.text.toString(),
                                contactNumber.text.toString(),
                                aadharNum.text.toString());
                            clearControllerValue();
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  clearControllerValue() {
    userName.clear();
    firstName.clear();
    lastName.clear();
    contactNumber.clear();
    aadharNum.clear();
    // setState(() {});
  }

  Widget buildTextFields(
      IconData? icon, String hintText, int index, var screenSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.width * 0.05),
      child: SizedBox(
        child: TextField(
          controller: index == 0
              ? firstName
              : index == 1
                  ? lastName
                  : index == 2
                      ? contactNumber
                      : index == 3
                          ? aadharNum
                          : userName,

          style: TextStyle(
              color: Colors.purple,
              fontSize:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? screenSize.width * 0.03
                      : screenSize.width * 0.046),
          // Set text color to black
          decoration: InputDecoration(
            label: Text(
              hintText,
              style: const TextStyle(color: Colors.deepPurpleAccent),
            ),
            prefixIcon: icon != null
                ? Padding(
                    padding: EdgeInsets.all(screenSize.width * 0.01),
                    child: Icon(
                      icon,
                      size: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? screenSize.width * 0.03
                          : screenSize.width * 0.06,
                      color: Colors.purple,
                    ),
                  )
                : null,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurpleAccent),
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? screenSize.width * 0.03
                        : screenSize.width * 0.046),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.8, size.width, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.55);
    path.quadraticBezierTo(
        size.width * 0.4, size.height, 0, size.height * 0.77);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
