import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hirelink/Screens/onBoarding.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => onBoardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/hirelink_logo.png',height: 200,),
              SizedBox(height: 32),
              Text('Welcome to HireLink',style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),)
            ],
          ),
        ),
      ),
    );
  }
}