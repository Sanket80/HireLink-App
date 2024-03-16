import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hirelink/Screens/CompanyDetails.dart';
import 'package:hirelink/Screens/chat_bot.dart';
import 'package:hirelink/Screens/statistics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Job> jobs = [
    Job(
      company: 'Google',
      location: 'California, USA',
      role: 'Sr. User Experience Designer',
      salary: const SalaryRange(minSalary: 85000, maxSalary: 120000),
      postedDaysAgo: 2,
      imageLink: 'assets/Google.png', // Replace with actual image link
    ),
    Job(
      company: 'Airbnb',
      location: 'San Francisco, USA',
      role: 'Sr. Fullstack Developer',
      salary: const SalaryRange(minSalary: 75000, maxSalary: 125000),
      postedDaysAgo: 2,
      imageLink: 'assets/airbnb.png', // Replace with actual image link
    ),
    Job(
      company: 'Slack',
      location: 'San Francisco, USA',
      role: 'Sr. Software Engineer',
      salary: const SalaryRange(minSalary: 90000, maxSalary: 150000),
      postedDaysAgo: 2,
      imageLink: 'assets/slack.png', // Replace with actual image link
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                'Offered Jobs',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return JobCard(job: job);
                },
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
                },
              ),
              GButton(
                icon: Icons.insert_chart_outlined,
                text: 'Stats',
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatisticsPage(),
                    ),
                  );
                },
              ),
              GButton(
                icon: Icons.chat,
                text: 'Chat',
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  Navigator.push(
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: GestureDetector(
        onTap: () {
          // Add your onTap function here
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompanyDetails(),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      job.imageLink,
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.company,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          job.location,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.bookmark_add_outlined),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  job.role,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${job.salary.minSalary} - \$${job.salary.maxSalary}',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(
                  'Posted on ${job.postedDaysAgo} days ago',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Job {
  final String company;
  final String location;
  final String role;
  final SalaryRange salary;
  final int postedDaysAgo;
  final String imageLink;

  Job({
    required this.company,
    required this.location,
    required this.role,
    required this.salary,
    required this.postedDaysAgo,
    required this.imageLink,
  });
}

class SalaryRange {
  final int minSalary;
  final int maxSalary;

  const SalaryRange({
    required this.minSalary,
    required this.maxSalary,
  });
}
