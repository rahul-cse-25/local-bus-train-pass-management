import 'dart:math';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  bool isRememberMe = false;
  bool isUserName = false;
  bool isHide = true;
  bool isReferralCodeApplied = false;
  var userId = '';

  TextEditingController forgetEmail = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();

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
              height: isSignUpScreen ? 380 : 250,
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
          Positioned(
              top: MediaQuery.of(context).size.height - 100,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(
                    isSignUpScreen ? "Or SignUp with" : "Or SignIn with",
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 40, left: 40, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildTextButtonForSocial(
                            EvaIcons.facebook, "facebook", palette.facebook),
                        buildTextButtonForSocial(
                            EvaIcons.google, "google", palette.google),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  AnimatedPositioned buildButtonHalfContainer(bool showShadow) {
    return AnimatedPositioned(
        duration: palette.formAnimeTime,
        curve: palette.formAnimation,
        top: isSignUpScreen ? 515 : 400,
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
                              true);
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
      bool isEmail, bool isUserName) {
    FocusNode focusNode = FocusNode();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: isUserName
            ? userName
            : isPassword
                ? password
                : email,
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
              Icons.person_2_outlined, "Username", false, false, true),
          buildTextField(Icons.mail_lock_outlined, "Email", false, true, false),
          buildTextField(
              Icons.lock_clock_outlined, "Password", true, false, false),
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
          )
        ],
      ),
    );
  }

  buildSignInSection() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          buildTextField(Icons.mail_lock, "Email", false, true, false),
          buildTextField(Icons.lock, "Password", true, false, false),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: palette.focusedIcon,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  const Text(
                    "Remember me",
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
                  ))
            ],
          )
        ],
      ),
    );
  }

  signUp(String email, String password, String username, bool isMale) async {
    if (username == '' || email == '' || password == '') {
      UiHelper.customDialog(context, 'Please Enter valid Credentials', 'Ok');
    } else {
      UserCredential? userCredentials;
      try {
        userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          await MongoDatabase.saveUserData({
            "username": username,
            "email": email,
            "isMale": isMale,
            "referralCode": ConstantServices.generateReferralCode(),
            "isReferralCodeApplied": isReferralCodeApplied
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

  signIn(String email, String password) async {
    if (email == '' || password == '') {
      UiHelper.customDialog(context, "Please Enter Credentials", "Ok");
    } else {
      UserCredential? userCredentials;
      try {
        userCredentials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
              userId = email.toString();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(userId: userId)));
          return null;
        });
      } on FirebaseAuthException catch (ex) {
        UiHelper.customDialog(context, ex.code.toString(), "Ok");
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
}
