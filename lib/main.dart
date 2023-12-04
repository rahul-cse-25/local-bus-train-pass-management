import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_project/LoginScreen.dart';
import 'package:flutter_project/SplashScreen.dart';

void main(){
  runApp(PassApp());
}

class PassApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp (
      title: "Public Transit Pass Information",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  var userNameFromLogin;
  HomeScreen(this.userNameFromLogin);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [
                  Color(0xFFFF9933), // Saffron
                  Color(0xFF128807), // Green
                  Color(0xFF0658AC), // Blue
                ],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
            // color: Colors.transparent, // Set the color to transparent
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(3),
              child: ImageSlideshow(
                width: double.infinity,
                height: 170,
                initialPage: 0,
                indicatorColor: Colors.teal,
                indicatorBackgroundColor: Colors.grey,
                children: [
                  Image.asset(
                    'assets/images/slider_image_1.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/slider_image_2.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/slider_image_3.jpg',
                    fit: BoxFit.cover,
                  ),
                ],
                autoPlayInterval: 5000,
                isLoop: true,
              ),
            ),
            Card(
              color: Colors.orange.shade100,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 500,
                  child: Column(
                      children: [
                        Text('Hello $userNameFromLogin,',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Text('How are you?, Welcome back !',style: TextStyle(color: Colors.black87,fontSize: 15,),),
                      ],
                    ),
                ),
                ),
              ),
            Card(
              color: Colors.blue.shade100,
              child:     Container(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Train Pass Information',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text('Pass Validity: 3 Months'),
                                Row(
                                  children: [
                                    Text('Pass Status: Active  '),
                                    Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CircularCountDownTimer(isReverse:true,isReverseAnimation: true,width: 200, height: 50, duration: 600, fillColor: Colors.green, ringColor: Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.green.shade100,
              child:     Container(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Bus Pass Information',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text('Pass Validity: 1 Months'),
                                Row(
                                  children: [
                                    Text('Pass Status: Active  '),
                                    Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CircularCountDownTimer(isReverse:true,isReverseAnimation: true,width: 200, height: 50, duration: 600, fillColor: Colors.green, ringColor: Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.qr_code),
                  color: Colors.green,
                  iconSize: 60,
                  onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.qr_code_2_rounded),
                  color: Colors.blue,
                  iconSize: 60,
                  onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.qr_code_rounded),
                  color: Colors.green,
                  iconSize: 60,
                  onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.qr_code_sharp),
                  color: Colors.blue,
                  iconSize: 60,
                  onPressed: (){},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.train),
                  color: Colors.blue,
                  iconSize: 60,
                  onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.bus_alert),
                  color: Colors.green,
                  iconSize: 60,
                  onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.on_device_training_outlined),
                  color: Colors.blue,
                  iconSize: 60,
                  onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.local_activity_rounded),
                  color: Colors.green,
                  iconSize: 60,
                  onPressed: (){},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.confirmation_num_outlined),
                  color: Colors.blue,
                  iconSize: 60,
                  onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.confirmation_number_sharp),
                  color: Colors.green,
                  iconSize: 60,
                  onPressed: (){},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}