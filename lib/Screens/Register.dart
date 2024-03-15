import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // Import flutter_pdfview package

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? _selectedPdfFileName;
  String? _selectedPdfFilePath; // Store the file path of the selected PDF

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedPdfFileName = result.files.single.name;
        _selectedPdfFilePath = result.files.single.path; // Store the file path
      });
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
                children: [
                  Image.asset('assets/Adobe PDF.png', height: 200, width: 200),
                  SizedBox(height: 10),
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
                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Register();
                        },
                      ));
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
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: _pickPdf,
                    child: Padding(
                      padding: const EdgeInsets.all(78.0),
                      child: Text(
                        'Select Resume',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
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
