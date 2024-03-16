import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
          Image.asset('assets/Team.png',height: 300,width: 300,),
          SizedBox(
            height: 40,
          ), // SizedBox
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Crafting Your Career Canvas',
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
              'AI-Powered Talent Match, Hiring Success Unlocked',
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
