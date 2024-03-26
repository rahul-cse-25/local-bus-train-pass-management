import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:public_transit_pass_info/config/constant.dart';
import 'package:public_transit_pass_info/config/palette.dart';
import 'package:public_transit_pass_info/config/uiHelper.dart';
import 'package:public_transit_pass_info/screens/HomeScreen.dart';

import '../config/mongoDB.dart';
import 'TermsAndConditionsPage.dart';

class SignInAndSignUpScreen extends StatefulWidget {
  const SignInAndSignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignInAndSignUpScreen();
}

class _SignInAndSignUpScreen extends State<SignInAndSignUpScreen> {
  bool isMale = true;
  bool isSignUpScreen = false;
  bool isUserName = false;
  bool isHide = true;
  bool isReferralCodeApplied = false;
  var userId = '';
  bool isTC = false;
  bool asTC = false;

  final MongoDatabase dbServices = MongoDatabase();

  TextEditingController forgetEmail = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController fullNameOfTC = TextEditingController();
  TextEditingController idNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palette.backGroundColor,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 250,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    palette.uperContainerFirst,
                    palette.uperContainerSecond,
                  ],
                )),
                child: Container(
                  margin: const EdgeInsets.only(left: 20, top: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Welcome ",
                              style: const TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              children: [
                            TextSpan(
                              text: isSignUpScreen ? "to Pass Info" : "Back",
                            ),
                            TextSpan(
                                text: isSignUpScreen
                                    ? "\n\t\t  Sign Up"
                                    : "\n\t\t  Sign In",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400))
                          ])),
                    ],
                  ),
                ),
              )),
          buildButtonHalfContainer(true),
          AnimatedPositioned(
            duration: palette.formAnimeTime,
            curve: palette.formAnimation,
            top: isSignUpScreen ? 180 : 200,
            child: AnimatedContainer(
              duration: palette.formAnimeTime,
              curve: palette.containerFormAnimation,
              height: isSignUpScreen && isTC ? 530 : isSignUpScreen && !isTC ? 425 : 250,
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5)
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUpScreen = false;
                              email.clear();
                              password.clear();
                              userName.clear();
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: !isSignUpScreen
                                      ? palette.textActiveColor
                                      : palette.textDeactiveColor,
                                ),
                              ),
                              if (!isSignUpScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.green,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUpScreen = true;
                              email.clear();
                              password.clear();
                              userName.clear();
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isSignUpScreen
                                      ? palette.textActiveColor
                                      : palette.textDeactiveColor,
                                ),
                              ),
                              if (isSignUpScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.green,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignUpScreen) builtSignUpSection(),
                    if (!isSignUpScreen) buildSignInSection(),
                  ],
                ),
              ),
            ),
          ),
          buildButtonHalfContainer(false),
        ],
      ),
    );
  }

  AnimatedPositioned buildButtonHalfContainer(bool showShadow) {
    return AnimatedPositioned(
        duration: palette.formAnimeTime,
        curve: palette.formAnimation,
        top: isSignUpScreen && isTC ? 660 : isSignUpScreen && !isTC ? 555 : 400,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            width: 90,
            height: 90,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  if (showShadow)
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1.5,
                        blurRadius: 10,
                        offset: const Offset(0, 1))
                ]),
            child: !showShadow
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!isSignUpScreen) {
                          signIn(
                              email.text.toString(), password.text.toString());
                        }
                        if (isSignUpScreen) {
                          signUp(
                              email.text.toString(),
                              password.text.toString(),
                              userName.text.toString(),
                              true,fullNameOfTC.text.toString(),idNumber.text.toString());
                        }
                        email.clear();
                        password.clear();
                        userName.clear();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.orange.shade200,
                                Colors.red.shade400
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            if (showShadow)
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1))
                          ]),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const Center(),
          ),
        ));
  }

  Widget buildTextField(IconData icon, String hintText, bool isPassword,
      bool isEmail, bool isUserName, TextEditingController fieldName) {
    FocusNode focusNode = FocusNode();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: fieldName,
        focusNode: focusNode,
        obscureText: isPassword && isHide,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus
                  ? palette.focusedIcon
                  : palette.trainThemeColor,
            ),
            suffixIcon: isPassword
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isHide = !isHide;
                        if (kDebugMode) {
                          print(isHide);
                        }
                      });
                    },
                    child:
                        Icon(isHide ? Icons.visibility_off : Icons.visibility),
                  )
                : const SizedBox.shrink(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: palette.iconColor),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: palette.trainComponantColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(35),
              ),
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }

  buildTextButtonForSocial(IconData icon, String name, Color backGroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        minimumSize: const Size(120, 40),
        side: const BorderSide(width: 1, color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        foregroundColor: Colors.white,
        backgroundColor: backGroundColor,
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 5,
          ),
          Text(
            name,
          ),
        ],
      ),
    );
  }

  builtSignUpSection() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          buildTextField(
              Icons.person_2_outlined, "Username", false, false, true,userName),
          buildTextField(Icons.mail_lock_outlined, "Email", false, true, false,email),
          buildTextField(
              Icons.lock_clock_outlined, "Password", true, false, false,password),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: palette.inputBorderDeactiveColor),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(Icons.male,
                            color: isMale
                                ? palette.iconSelected
                                : palette.iconColor),
                      ),
                      const Text(
                        "Male",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: palette.inputBorderDeactiveColor),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(Icons.female,
                            color: isMale
                                ? palette.iconColor
                                : palette.iconSelected),
                      ),
                      const Text(
                        "Female",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: isTC,
                activeColor: palette.focusedIcon,
                onChanged: (value) {
                  setState(() {
                    isTC = !isTC;
                  });
                },
              ),
              const Text(
                "Are you want to Sign Up as  TC (Ticket Collector) ?",
                style: TextStyle(
                    color: palette.textDeactiveColor, fontSize: 12),
              )
            ],
          ),
          if(isTC)
          buildTextField(Icons.drive_file_rename_outline, "Enter your Full Name", false, false, false,fullNameOfTC),
          if(isTC)
            buildTextField(Icons.perm_identity_outlined, "Enter your id number", false, false, false, idNumber),
          Container(
            width: 200,
            margin: const EdgeInsets.only(top: 20),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "By pressing 'Submit' you agree to our ",
                    style: const TextStyle(color: palette.iconColor),
                    children: [
                      TextSpan(
                          text: "term & conditions",
                          style: const TextStyle(color: palette.termConditions),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TermsAndConditionsPage()));
                            })
                    ])),
            // ),
          ),

        ],
      ),
    );
  }

  buildSignInSection() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          buildTextField(Icons.mail_lock, "Email", false, true, false,email),
          buildTextField(Icons.lock, "Password", true, false, false,password),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: asTC,
                    activeColor: palette.focusedIcon,
                    onChanged: (value) {
                      setState(() {
                        asTC = !asTC;
                      });
                    },
                  ),
                  const Text(
                    "Login as TC ?",
                    style: TextStyle(
                        color: palette.textDeactiveColor, fontSize: 12),
                  )
                ],
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetScreen()));
                      customForgetDialog(context, "Close");
                    });
                  },
                  child: const Text(
                    "Forget Password ?",
                    style: TextStyle(
                        color: palette.forgetButtonColor, fontSize: 12),
                  )),
            ],
          )
        ],
      ),
    );
  }

  signUp(String email, String password, String username, bool isMale,String fullNameOfTC,String idNumber) async {

    if(isTC && (fullNameOfTC.isEmpty || idNumber.isEmpty)){
      UiHelper.customDialog(context, "Please fill the TC details", "OK");
      return;
    }

    if(isTC && (fullNameOfTC.isNotEmpty && idNumber.isNotEmpty) && await isValidTCdetails(fullNameOfTC,idNumber) != true){
      UiHelper.customDialog(context, "Entered TC detail is not correct please fill the correct information or signUp as normal user", "OK");
      return;
    }else{
      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        UiHelper.customDialog(context, 'Please Enter valid Credentials', 'OK');
      }
      else {
        UserCredential? userCredentials;
        try {
          userCredentials = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) async {
            User? user = FirebaseAuth.instance.currentUser;
            await MongoDatabase.saveUserData({
              "userUID":user?.uid,
              "username": username,
              "email": email,
              "isMale": isMale,
              "referralCode": ConstantServices.generateReferralCode(),
              "isReferralCodeApplied": isReferralCodeApplied,
              "isTC": isTC
            }, USER_DETAILS_COLLECTION);
            if (kDebugMode) {
              print("**********************************************");
              print("UserID: $userId");
              print("**********************************************");
            }
            UiHelper.customDialog(
                context, 'Sign Up Successful Please Sign In to proceed', "OK");
            setState(() {
              isSignUpScreen = false;
            });
            return null;
          });
        } on FirebaseAuthException catch (ex) {
          return UiHelper.customDialog(context, ex.code.toString(), 'OK');
        }
      }
    }
  }

  signIn(String email, String password) async {
    if(asTC && (email.isNotEmpty || password.isNotEmpty) && await isVerifiedTC(email) != true){
      if (kDebugMode) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Came in asTC Login");
      }
      UiHelper.customDialog(context, "Incorrect details! Pay attention while login.", "OK");
    }else{
      if (kDebugMode) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Not Came in asTC Login");
      }
      if (email.isEmpty || password.isEmpty) {
        UiHelper.customDialog(context, "Please Enter Credentials", "Ok");
      }
      else {
        UserCredential? userCredentials;
        try {
          userCredentials = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password)
              .then((value) {
            userId = email.toString();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(userId: userId,asTC: asTC)));
            return null;
          });
        } on FirebaseAuthException catch (ex) {
          UiHelper.customDialog(context, ex.code.toString(), "OK");
        }
      }
    }
  }

  forgetPassword(String email) async {
    if (email == '') {
      UiHelper.customDialog(context, "Please Enter Email", "OK");
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  String generateOTP() {
    final random = Random();
    final digits = List<int>.generate(6, (index) => random.nextInt(10));
    return digits.join('');
  }

  customForgetDialog(BuildContext context, String? actionText) {
    bool isGetOTPClicked = false;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: Colors.black,
            title: const Text(
              "Forget Password ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w900), // Change color here
            ),
            content: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildForgetTextField(Icons.email, "Enter your Email "),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            if (forgetEmail.text.toString().isEmpty) {
                              UiHelper.customDialog(
                                  context, "Something went wrong", "OK");
                            } else {
                              UiHelper.customDialog(
                                  context,
                                  "Reset Password link has been Sent to the Email",
                                  "OK");
                              forgetPassword(forgetEmail.text.toString());
                            }
                            setState(() {
                              forgetEmail.clear();
                            });
                          },
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              foregroundColor:
                                  const MaterialStatePropertyAll(Colors.white),
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.blue),
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.25))),
                          child: const Text("Continue")),
                    ),
                  ],
                ),
              ),
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

  buildForgetTextField(IconData icon, String hintText) {
    FocusNode focusNode = FocusNode();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: forgetEmail,
        focusNode: focusNode,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus
                  ? palette.focusedIcon
                  : palette.trainThemeColor,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: palette.iconColor),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: palette.trainThemeColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(35),
              ),
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }

  Future<bool?> isValidTCdetails(String fullNameOfTC, String idNumber) async {
    bool? isValid = await dbServices.checkTCDetails(fullNameOfTC, idNumber);
    if(isValid != null) {
      return isValid;
    } else {
      return false;
    }
  }

  Future<bool?> isVerifiedTC(String email) async {
    bool? isValid = await dbServices.isVerifiedTCDetails(email);
    if(isValid != null) {
      return isValid;
    } else {
      return false;
    }
  }
}
