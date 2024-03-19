import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hirelink/Screens/Form.dart'; // Import flutter_pdfview package
import 'package:http/http.dart' as http;

import '../utils/ip.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? _selectedPdfFileName;
  String? _selectedPdfFilePath;

  // Function to pick PDF file
  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedPdfFileName = result.files.single.name;
        _selectedPdfFilePath = result.files.single.path;
      });
    }
  }

  // Function to submit the selected PDF file to the backend using multipart/form-data
  void submitResumeToBackend() async {
    try {
      if (_selectedPdfFilePath != null) {
        final file = File(_selectedPdfFilePath!);

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://$ipAddress:$port/api/extract'),
        );

        // Add the file as a File object directly to the request
        request.files.add(
          http.MultipartFile(
            'file',
            file.readAsBytes().asStream(), // Use asStream() to convert List<int> to Stream<List<int>>
            file.lengthSync(), // Provide the length of the file
            filename: _selectedPdfFileName!, // Provide the file name
          ),
        );

        var response = await request.send();

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Text extracted successfully'),
              backgroundColor: Color(0xffe11d48),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to extract text'),
              backgroundColor: Color(0xffe11d48),
            ),
          );
        }
      }
    } catch (error) {
      // Handle and log the error
      print('Error submitting resume: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while submitting the resume'),
          backgroundColor: Color(0xffe11d48),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedPdfFileName != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Image.asset('assets/Adobe PDF.png', height: 200, width: 200),
                  GestureDetector(
                    onTap: () {
                      if (_selectedPdfFilePath != null) {
                        // Open the selected PDF file using the flutter_pdfview package
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PdfViewPage(pdfPath: _selectedPdfFilePath!);
                            },
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        _selectedPdfFileName!,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 150),
                  GestureDetector(
                    onTap: () {
                      submitResumeToBackend();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10),
                        color: Color(0xffe11d48),
                      ),
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      child: Text(
                        'Upload Resume',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            if (_selectedPdfFileName == null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xffe11d48), width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: _pickPdf,
                    child: Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: Column(
                        children: [
                          // pdf icon
                          Image.asset('assets/Adobe PDF.png', height: 120, width: 120,),
                          Text(
                            'Select Resume',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20),
            // Add any other widgets or UI elements here
          ],
        ),
      ),
    );
  }
}

// PdfViewPage widget to display the selected PDF file
class PdfViewPage extends StatelessWidget {
  final String pdfPath;

  const PdfViewPage({Key? key, required this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
