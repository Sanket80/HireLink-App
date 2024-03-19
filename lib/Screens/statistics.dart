import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hirelink/Bar%20Graph/bar_graph.dart';
import 'package:hirelink/Screens/HomeScreen.dart';
import 'package:hirelink/Screens/Profile.dart';

import 'chat_bot.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int _selectedIndex = 1;

  List<double> salary = [1000, 2000, 3000, 4000, 5000];
  // Dummy data for sector distribution
  List<Map<String, dynamic>> sectorData = [
    {'sector': 'Tech', 'percentage': 40.0, 'color': Colors.black},
    {'sector': 'Health', 'percentage': 30.0, 'color': Color(0xffe11d48)},
    {'sector': 'Finance', 'percentage': 20.0, 'color': Colors.grey.shade600},
    {'sector': 'Edu', 'percentage': 10.0, 'color': Color(0xffFf5d5d)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 400,
                child: MyBarGraph(salary: salary),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Computer Science Domain Salaries Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            ),
            SizedBox(height: 84),
            Container(
              height: 300, // Set the desired height
              width: double.infinity, // Set the width to match the parent width
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text("Sector Distribution",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),),
                  PieChart(
                    swapAnimationDuration: const Duration(milliseconds: 750),
                    swapAnimationCurve: Curves.easeInQuint,
                    PieChartData(
                      sections: List.generate(
                        sectorData.length,
                            (index) => PieChartSectionData(
                          value: (sectorData[index]['percentage'] as double) ?? 0,
                          color: sectorData[index]['color'] as Color,
                          title: '${sectorData[index]['sector']} ${((sectorData[index]['percentage'] as double)).toStringAsFixed(2)}%',
                          radius: 60,
                          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            selectedIndex: _selectedIndex,
            backgroundColor: Colors.black,
            activeColor: Colors.white,
            color: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(12),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
              GButton(
                icon: Icons.insert_chart_outlined,
                text: 'Stats',
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              GButton(
                icon: Icons.chat,
                text: 'Chat',
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ChatBot()),
                  );
                },
              ),
              GButton(
                icon: Icons.home_work_outlined,
                text: 'Jobs',
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
