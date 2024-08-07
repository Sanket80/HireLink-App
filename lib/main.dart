import 'package:flutter/material.dart';
import 'package:hirelink/Screens/Form.dart';
import 'package:hirelink/Screens/HomeScreen.dart';
import 'package:hirelink/Screens/Profile.dart';
import 'package:hirelink/Screens/Register.dart';
import 'package:hirelink/Screens/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HireLink',
      home: const SplashScreen(),
    );
  }
}
