import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              // Widget 1
            ),
          ),
          Image.asset('assets/Interview.png',height: 230,width: 300,),
          SizedBox(
            height: 40,
          ), // SizedBox
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Connecting Talent And Ambition',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 6,
          ), // SizedBox
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Text(
              'Streamlined interviews help you evaluate talent and make informed hiring decisions.',
              style: TextStyle(fontSize: 18,color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 100,
              // Widget 1
            ),
          ),
        ],
      ),
    );
  }
}
