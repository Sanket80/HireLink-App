import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hirelink/Screens/HomeScreen.dart';
import 'package:hirelink/Widgets/text_field_input.dart';
import 'package:http/http.dart' as http;

import '../utils/ip.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class ResumeInformation {
  ContactInformation contactInformation;
  String summary;
  List<Education> education;
  List<WorkExperience> workExperience;
  List<String> skills;
  List<Certification> certifications;
  List<ProjectEntry> projects;
  List<AchievementEntry> achievements;
  AdditionalInformation additionalInformation;
  Security security;

  ResumeInformation({
    required this.contactInformation,
    required this.summary,
    required this.education,
    required this.workExperience,
    required this.skills,
    required this.certifications,
    required this.projects,
    required this.achievements,
    required this.additionalInformation,
    required this.security,
  });
}

class ContactInformation {
  String firstName;
  String lastName;
  String email;
  String phone;
  String address;

  ContactInformation({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
  });
}

class Education {
  String school;
  String degree;
  String major;
  String graduationDate;
  String aggregate;

  Education({
    required this.school,
    required this.degree,
    required this.major,
    required this.graduationDate,
    required this.aggregate,
  });
}

class WorkExperience {
  String company;
  String jobTitle;
  String jobLocation;
  String jobStartDate;
  String jobEndDate;
  String jobDescription;

  WorkExperience({
    required this.company,
    required this.jobTitle,
    required this.jobLocation,
    required this.jobStartDate,
    required this.jobEndDate,
    required this.jobDescription,
  });
}

class Certification {
  String certification;
  String issuingOrganization;
  String issueDate;
  String expiryDate;

  Certification({
    required this.certification,
    required this.issuingOrganization,
    required this.issueDate,
    required this.expiryDate,
  });
}

class ProjectEntry {
  String title;
  String date;
  String description;

  ProjectEntry({
    required this.title,
    required this.date,
    required this.description,
  });
}

class AchievementEntry {
  String title;
  String date;

  AchievementEntry({
    required this.title,
    required this.date,
  });
}

class AdditionalInformation {
  String languages;
  String volunteerExperience;
  String publications;
  String interests;

  AdditionalInformation({
    required this.languages,
    required this.volunteerExperience,
    required this.publications,
    required this.interests,
  });
}

class Security {
  String password;
  String confirmPassword;

  Security({
    required this.password,
    required this.confirmPassword,
  });
}

class _FormScreenState extends State<FormScreen> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _AddressController = TextEditingController();

  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _graduationDateController = TextEditingController();
  final TextEditingController _AggrigateController = TextEditingController();

  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobLocationController = TextEditingController();
  final TextEditingController _jobStartDateController = TextEditingController();
  final TextEditingController _jobEndDateController = TextEditingController();
  final TextEditingController _jobDescriptionController = TextEditingController();

  final TextEditingController _certificationController = TextEditingController();
  final TextEditingController _issuingOrganizationController = TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();

  final TextEditingController _ProjecttitleController = TextEditingController();
  final TextEditingController _ProjectDescriptionController = TextEditingController();
  final TextEditingController _ProjectDateController = TextEditingController();

  final TextEditingController _AchievementtitleController = TextEditingController();
  final TextEditingController _AchievementDateController = TextEditingController();

  final TextEditingController _LanguagesController = TextEditingController();
  final TextEditingController _VolunteerExperienceController = TextEditingController();
  final TextEditingController _PublicationsController = TextEditingController();
  final TextEditingController _InterestsController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _skills = [];
  final List<Certification> _certifications = [];
  final List<ProjectEntry> _projects = [];
  final List<AchievementEntry> _achievements = [];
  bool _isLoading = false;

  // Register user to the backend
  void _registerUser() async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (_firstNameController.text.isEmpty ||
          _lastNameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _phoneController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _confirmPassController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill the reqired fields'),
            backgroundColor: Color(0xffe11d48),
          ),
        );
        return;
      }

      var contactInformationJson =
        {
          'firstName': _firstNameController.text.trim(),
          'lastName': _lastNameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          'address': _AddressController.text.trim(),
        };

      var educationJson = [
        {
          'school': _schoolController.text.trim(),
          'degree': _degreeController.text.trim(),
          'major': _majorController.text.trim(),
          'graduationDate': _graduationDateController.text.trim(),
          'aggregate': _AggrigateController.text.trim(),
        }
      ];

      var workExperienceJson = [
        {
          'company': _companyController.text.trim(),
          'jobTitle': _jobTitleController.text.trim(),
          'jobLocation': _jobLocationController.text.trim(),
          'jobStartDate': _jobStartDateController.text.trim(),
          'jobEndDate': _jobEndDateController.text.trim(),
          'jobDescription': _jobDescriptionController.text.trim(),
        }
      ];

      var skillsJson = _skills;

      var certificationsJson = _certifications.map((certification) {
        return {
          'certification': certification.certification,
          'issuingOrganization': certification.issuingOrganization,
          'issueDate': certification.issueDate,
          'expiryDate': certification.expiryDate,
        };
      }).toList();

      var projectsJson = _projects.map((project) {
        return {
          'title': project.title,
          'date': project.date,
          'description': project.description,
        };
      }).toList();

      var achievementsJson = _achievements.map((achievement) {
        return {
          'title': achievement.title,
          'date': achievement.date,
        };
      }).toList();

      var additionalInformationJson = {
        'languages': _LanguagesController.text.trim(),
        'volunteerExperience': _VolunteerExperienceController.text.trim(),
        'publications': _PublicationsController.text.trim(),
        'interests': _InterestsController.text.trim(),
      };

      var securityJson = {
        'password': _passwordController.text.trim(),
        'confirmPassword': _confirmPassController.text.trim(),
      };

      var roleJson = {
        'data': 'candidate'
      };

      var resumeInfoJson = {
        'contactInformation': contactInformationJson,
        'summary': 'Summary',
        'education': educationJson,
        'workExperience': workExperienceJson,
        'skills': skillsJson,
        'certifications': certificationsJson,
        'projects': projectsJson,
        'achievements': achievementsJson,
        'additionalInformation': additionalInformationJson,
        'security': securityJson,
        'role': roleJson,
      };

      var url = 'http://$ipAddress:$port/api/register';

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(resumeInfoJson),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registered successfully'),
            backgroundColor: Color(0xffe11d48),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to register'),
            backgroundColor: Color(0xffe11d48),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 16,
                  top: 8,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // or MainAxisAlignment.spaceAround
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/hirelink_logo.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Text(
                                'HireLink',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Please fill out the form below for missing fields',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Contact Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFieldInput(textEditingController: _firstNameController, hintText: 'First Name', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _lastNameController, hintText: 'Last Name', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _emailController, hintText: 'Email', textInputType: TextInputType.emailAddress),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _phoneController, hintText: 'Phone', textInputType: TextInputType.phone),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _AddressController, hintText: 'Address', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: Colors.white,
                      child: TextField(
                        maxLines: null, // Set to null for unlimited lines, or specify a number
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Summary',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Education',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFieldInput(textEditingController: _schoolController, hintText: 'School', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _degreeController, hintText: 'Degree', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _majorController, hintText: 'Major', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _graduationDateController, hintText: 'Graduation Date', textInputType: TextInputType.datetime),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _AggrigateController, hintText: 'Aggrigate Marks', textInputType: TextInputType.number),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Work Experience',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFieldInput(textEditingController: _companyController, hintText: 'Company', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _jobTitleController, hintText: 'Job Title', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _jobLocationController, hintText: 'Job Location', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _jobStartDateController, hintText: 'Job Start Date', textInputType: TextInputType.datetime),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _jobEndDateController, hintText: 'Job End Date', textInputType: TextInputType.datetime),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _jobDescriptionController, hintText: 'Job Description', textInputType: TextInputType.text),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: _textEditingController,
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _skills.add(value.trim());
                            _textEditingController.clear(); // Clear the text field after adding skill
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter a skill',
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: _skills.asMap().entries.map((entry) {
                        return Chip(
                          label: Text(entry.value),
                          onDeleted: () {
                            setState(() {
                              _skills.removeAt(entry.key);
                            });
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Certifications',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFieldInput(textEditingController: _certificationController, hintText: 'Certification', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _issuingOrganizationController, hintText: 'Issuing Organization', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _issueDateController, hintText: 'Issue Date', textInputType: TextInputType.datetime),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _expirationDateController, hintText: 'Expiration Date', textInputType: TextInputType.datetime),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String certification = _certificationController.text.trim();
                        String issuingOrganization = _issuingOrganizationController.text.trim();
                        String issueDate = _issueDateController.text.trim();
                        String expiryDate = _expirationDateController.text.trim();

                        if (certification.isNotEmpty && issuingOrganization.isNotEmpty && issueDate.isNotEmpty && expiryDate.isNotEmpty) {
                          setState(() {
                            _certifications.add(Certification(
                              certification: certification,
                              issuingOrganization: issuingOrganization,
                              issueDate: issueDate,
                              expiryDate: expiryDate,
                            ));
                            // Clear input fields
                            _certificationController.clear();
                            _issuingOrganizationController.clear();
                            _issueDateController.clear();
                            _expirationDateController.clear();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // Background color
                        onPrimary: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                      ),
                      child: Text('Add Certification'),
                    ),
                    // Display added certifications
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _certifications.length,
                      itemBuilder: (context, index) {
                        Certification certification = _certifications[index];
                        return ListTile(
                          title: Text(certification.certification),
                          subtitle: Text(
                            'Issuing Organization: ${certification.issuingOrganization}\n'
                                'Issue Date: ${certification.issueDate}\n'
                                'Expiry Date: ${certification.expiryDate}',
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _certifications.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Projects',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFieldInput(textEditingController: _ProjecttitleController, hintText: 'Title', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _ProjectDateController, hintText: 'Date', textInputType: TextInputType.datetime),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _ProjectDescriptionController, hintText: 'Description', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String title = _ProjecttitleController.text.trim();
                        String date = _ProjectDateController.text.trim();
                        String description = _ProjectDescriptionController.text.trim();

                        if (title.isNotEmpty && date.isNotEmpty && description.isNotEmpty) {
                          setState(() {
                            _projects.add(ProjectEntry(
                              title: title,
                              date: date,
                              description: description,
                            ));
                            // Clear input fields
                            _ProjecttitleController.clear();
                            _ProjectDateController.clear();
                            _ProjectDescriptionController.clear();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // Background color
                        onPrimary: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                      ),
                      child: Text('Add Project'),
                    ),
                    // Display added projects
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _projects.length,
                      itemBuilder: (context, index) {
                        ProjectEntry project = _projects[index];
                        return ListTile(
                          title: Text(project.title),
                          subtitle: Text(
                            'Date: ${project.date}\n'
                                'Description: ${project.description}',
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _projects.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Achievements',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFieldInput(textEditingController: _AchievementtitleController, hintText: 'Title', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _AchievementDateController, hintText: 'Date', textInputType: TextInputType.datetime),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String title = _AchievementtitleController.text.trim();
                        String date = _AchievementDateController.text.trim();

                        if (title.isNotEmpty && date.isNotEmpty) {
                          setState(() {
                            _achievements.add(AchievementEntry(
                              title: title,
                              date: date,
                            ));
                            // Clear input fields
                            _AchievementtitleController.clear();
                            _AchievementDateController.clear();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // Background color
                        onPrimary: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                      ),
                      child: Text('Add Achievement'),
                    ),
                    // Display added achievements
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _achievements.length,
                      itemBuilder: (context, index) {
                        AchievementEntry achievement = _achievements[index];
                        return ListTile(
                          title: Text(achievement.title),
                          subtitle: Text(
                            'Date: ${achievement.date}',
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _achievements.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),

                    Row(
                      children: [
                        Icon(Icons.circle_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Additional Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFieldInput(textEditingController: _LanguagesController, hintText: 'Languages', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _VolunteerExperienceController, hintText: 'Volunteer Experience', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _PublicationsController, hintText: 'Publications', textInputType: TextInputType.text),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _InterestsController, hintText: 'Interests', textInputType: TextInputType.text),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Security',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFieldInput(textEditingController: _passwordController, hintText: 'Password', textInputType: TextInputType.visiblePassword,isPass: true,),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldInput(textEditingController: _confirmPassController, hintText: 'Confirm Password', textInputType: TextInputType.visiblePassword,isPass: true,),
                    SizedBox(
                      height: 16,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                _registerUser();
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffe11d48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17.9,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
