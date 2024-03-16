import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hirelink/Bar%20Graph/bar_graph.dart';
import 'package:hirelink/Screens/HomeScreen.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int _selectedIndex = 1;

  List<double> salary = [1000, 2000, 3000, 4000, 5000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Center(
        child: SizedBox(
          height: 400,
            child: MyBarGraph(salary: salary),),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),),);
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
                },
              ),
              GButton(
                icon: Icons.home_work_outlined,
                text: 'Jobs',
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
