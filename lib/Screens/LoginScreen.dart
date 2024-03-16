import 'package:flutter/material.dart';
import 'package:hirelink/Screens/SignUpScreen.dart';
import 'package:hirelink/Screens/onBoarding.dart';
import 'package:hirelink/Widgets/text_field_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              Image.asset('assets/hirelink_logo.png',height: 200,),
              SizedBox(height: 8),
              Text(
                'AI-Powered Talent Match, Hiring Success Unlocked',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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

              SizedBox(height: 16),
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

              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your onPressed function here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Background color
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


              SizedBox(height: 16),
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
                          builder: (context) => SignUpScreen(),
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
              )

            ],
          ),
        ),
      ),
    );
  }
}
