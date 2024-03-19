
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hirelink/Screens/SignUpScreen.dart';
import 'package:hirelink/Screens/onBoarding.dart';
import 'package:hirelink/Widgets/text_field_input.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/ip.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _loginUser() async {
    try{
      setState(() {
        _isLoading = true;
      });
      if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill all the fields'),
            backgroundColor: Color(0xffe11d48),
          ),
        );
        return;
      }
      var signBody = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      var url = 'http://$ipAddress:$port/api/login';

      var response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(signBody));

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // prefs.setString('token', jsonResponse['token']);
        // print('Token: ${jsonResponse['token']}');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        print('Error');
      }
    }
    catch(e){
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Container(), flex: 1),
                  Image.asset('assets/hirelink_logo.png',height: 200,),
                  SizedBox(height: 8),
                  Text(
                    'Unlock your Career with AI Powered Talent Match',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loginUser,
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffe11d48), // Background color
                        onPrimary: Colors.white, // Text color
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 32),
                  Flexible(child: Container(), flex: 2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text('Don\'t have an account? '),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => onBoardingScreen(),
                            ),);
                        },
                        child: Container(
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffe11d48),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
