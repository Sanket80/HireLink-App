import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/ip.dart';
import 'CompanyDetails.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<JobData>> _jobListFuture;

  @override
  void initState() {
    super.initState();
    _jobListFuture = _fetchJobs();
  }

  Future<List<JobData>> _fetchJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '';

    final response = await http.post(
      Uri.parse('http://$ipAddress:$port/api/shownotifications'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': userId}),
    );

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      final List<dynamic> jobDataList = responseData['jobData'];
      return jobDataList.map((data) => JobData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  final List<String> logoImages = [
    'assets/Google.png', // Replace with your logo paths/URLs
    'assets/airbnb.png',
    'assets/slack.png',
  ];
  late String selectedLogo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
      ),
      body: FutureBuilder<List<JobData>>(
        future: _jobListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No job openings available'),
            );
          } else {
            final List<JobData> jobDataList = snapshot.data!;
            return Container(
              color: Color(0xfff4f4ee),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      'Offered Jobs',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: jobDataList.length,
                      itemBuilder: (context, index) {
                        final jobData = jobDataList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CompanyDetails();
                                  },
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Card(
                                color: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                         Image.asset(
                                           logoImages[index % logoImages.length],
                                           height: 50,
                                           width: 50,),
                                          SizedBox(width: 16),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                jobData.companyInfo.companyName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                jobData.jobDescription.location,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // bookmark icon
                                          Spacer(),
                                          IconButton(
                                            icon: Icon(Icons.bookmark_border),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        jobData.jobDescription.title,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        jobData.jobDescription.role,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Salary: ${jobData.jobDescription.salary}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class JobData {
  final JobDescription jobDescription;
  final CompanyInfo companyInfo;

  JobData({
    required this.jobDescription,
    required this.companyInfo,
  });

  factory JobData.fromJson(Map<String, dynamic> json) {
    return JobData(
      jobDescription: JobDescription.fromJson(json['jobDescription']),
      companyInfo: CompanyInfo.fromJson(json['companyInfo']),
    );
  }
}

class JobDescription {
  final String id;
  final String title;
  final String type;
  final String location;
  final String description;
  final String role;
  final List<String> skills;
  final int experience;
  final String salary;
  final String status;
  final DateTime date;

  JobDescription({
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.description,
    required this.role,
    required this.skills,
    required this.experience,
    required this.salary,
    required this.status,
    required this.date,
  });

  factory JobDescription.fromJson(Map<String, dynamic> json) {
    return JobDescription(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      location: json['location'],
      description: json['description'],
      role: json['role'],
      skills: List<String>.from(json['skills']),
      experience: json['experience'],
      salary: json['salary'],
      status: json['status'],
      date: DateTime.parse(json['date']),
    );
  }
}

class CompanyInfo {
  final String companyName;
  final String companyAddress;
  final String companyPhone;
  final String companyEmail;
  final String companyWebsite;
  final String companyDescription;

  CompanyInfo({
    required this.companyName,
    required this.companyAddress,
    required this.companyPhone,
    required this.companyEmail,
    required this.companyWebsite,
    required this.companyDescription,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      companyName: json['companyName'],
      companyAddress: json['companyAddress'],
      companyPhone: json['companyPhone'],
      companyEmail: json['companyEmail'],
      companyWebsite: json['companyWebsite'],
      companyDescription: json['companyDescription'],
    );
  }
}
