import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hirelink/Screens/statistics.dart';
import 'package:http/http.dart' as http;

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  int _selectedIndex = 2;
  ChatUser myself = ChatUser(id: '1', firstName: 'User');
  ChatUser bot = ChatUser(id: '2', firstName: 'Gemini');
  List<ChatMessage> allMessages = [];
  List<ChatUser> typing=[];

  final oururl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyBagXwZetCoxVBv2Yj0Zj_iskz6ctDdZN0';
  final header = {
    'Content-Type': 'application/json',
  };

  getdata(ChatMessage m) async {
    typing.add(bot);
    setState(() {
      allMessages.add(m);
    });

    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };

    await http
        .post(Uri.parse(oururl), headers: header, body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        // Perform null checks before accessing nested properties
        if (result != null && result['candidates'] != null && result['candidates'].isNotEmpty) {
          var text = result['candidates'][0]['content']['parts'][0]['text'];
          print(text);

          ChatMessage m1 = ChatMessage(
            text: text,
            user: bot,
            createdAt: DateTime.now(),
          );

          allMessages.insert(0, m1);



        } else {
          print('Invalid response structure.');
        }
      } else {
        print('Error Occurred: ${value.statusCode}');
      }
    }).catchError((e) {
      print('Error Occurred: $e');
    });
    typing.remove(bot);
    setState(() {});
  }

  // AIzaSyBagXwZetCoxVBv2Yj0Zj_iskz6ctDdZN0
  // curl \
  // -H 'Content-Type: application/json' \
  // -d '{"contents":[{"parts":[{"text":"Write a story about a magic backpack"}]}]}' \
  // -X POST https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_API_KEY

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask your Doubts!'),
        iconTheme: const IconThemeData(
          color: Colors.black, // Change your color here
        ),
      ),
      body: DashChat(
        typingUsers: typing,
        currentUser: myself,
        onSend: (ChatMessage m) {
          getdata(m);
        },
        messages: List<ChatMessage>.generate(allMessages.length, (index) {
          // Alternate between user and bot messages based on the index
          if (index.isEven) {
            return allMessages[index ~/ 2]; // User message
          } else {
            return allMessages[index ~/ 2 + 1]; // Bot response
          }
        }),
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