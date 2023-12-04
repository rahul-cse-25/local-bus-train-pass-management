import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Enter Your Name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                  Container(height: 12,),
                  TextField(
                    decoration: InputDecoration(
                      label: Text('First Name'),
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
                      hintText: "Enter Your First Name",
                    ),
                  ),
                  Container(height: 12,),
                  TextField(
                    decoration: InputDecoration(
                      label: Text('Surname'),
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
                      hintText: "Enter Surname",
                    ),
                  ),
                ],
              ),
              Container(height: 15,),
              Column(
                children: [
                  Text('Enter Your BirthDate and Gender',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                  Container(height: 12,),
                  Row(
                    children: [

                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}