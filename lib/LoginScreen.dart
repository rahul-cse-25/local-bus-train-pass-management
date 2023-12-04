import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/ForgetScreen.dart';
import 'package:flutter_project/RegisterScreen.dart';
import 'package:flutter_project/main.dart';

class LoginScreen extends StatelessWidget {
  var userName = TextEditingController();
  var userKey = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign in',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 40),
                ),
                Container(
                  height: 60,
                ),
                TextField(
                  controller: userName,
                  decoration: InputDecoration(
                    label: Text('Username'),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blue.shade300,
                          width: 2,
                        )),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white70,
                          width: 2,
                        )),
                    hintText: "Enter Username",
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.mail,
                        color: Colors.orange,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Container(
                  height: 11,
                ),
                TextField(
                  controller: userKey,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    label: Text('Password'),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blue.shade300,
                          width: 2,
                        )),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white70,
                          width: 2,
                        )),
                    hintText: "Enter Password",
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.password_sharp,
                        color: Colors.orange,
                      ),
                      onPressed: () {},
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.red.shade400,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Container(
                  height: 11,
                ),
                ElevatedButton(
                  onPressed: () {
                    String userId = userName.text.toString();
                    String userPass = userKey.text.toString();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(userName.text.toString()),
                        ));
                  },
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green), // Change the color to your desired color
                  ),
                ),
                Container(
                  height: 11,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide.none),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ));
                      },
                      child: Text(
                        'Register...',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      width: 50,
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide.none),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetScreen(),
                            ));
                      },
                      child: Text(
                        'Forget Password ?',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
