import 'package:flutter/material.dart';
import 'package:hirelink/Screens/LoginScreen.dart';
import 'package:hirelink/Widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/hirelink_logo.png',height: 100,),
                  Text(
                    'Hello There!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Register below with your details",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  TextFieldInput(textEditingController: _firstname, hintText: 'First Name', textInputType: TextInputType.text),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(textEditingController: _lastname, hintText: 'Last Name', textInputType: TextInputType.text),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(textEditingController: _phonenumber, hintText: 'Phone Number', textInputType: TextInputType.phone),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(textEditingController: _email, hintText: 'Email', textInputType: TextInputType.emailAddress),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(textEditingController: _password, hintText: 'Password', textInputType: TextInputType.visiblePassword, isPass: true),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(textEditingController: _confirmPassword, hintText: 'Confirm Password', textInputType: TextInputType.visiblePassword, isPass: true),
                  SizedBox(
                    height: 20,
                  ),

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
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text('Don\'t have an account? '),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),);
                        },
                        child: Container(
                          child: Text(
                            'Login',
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
        ),
      ),
    );
  }
}
