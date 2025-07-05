import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

import 'message.dart';


class MediMate extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   ChatScreen();
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _userInput =TextEditingController();

  static const apiKey = "AIzaSyDpn9KPheXrrLe3jX8ZGK-r8wbsbUZ-EBA";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [];

  Future<void> sendMessage() async {
    final message = _userInput.text.trim();

    // Add the user's message to the chat
    setState(() {
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
    });

    // Check for the specific question and provide a predefined response
    if (message.toLowerCase() == "who are you" ||message.toLowerCase() == "who are you?"||message.toLowerCase() == "who are you ?"||message.toLowerCase() == "who are you ? ") {
      setState(() {
        _messages.add(Message(isUser: false, message: "I am MediMate developed by SkinnScan AI team. I am your Personal Medical Assistant. I follow instructions extremely well. How may I assist you today?", date: DateTime.now()));
      });
      _userInput.clear(); // Clear the input field
      return;
    }

    // Send the message to the Generative AI API
    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    // Add the AI response to the chat
    setState(() {
      _messages.add(Message(isUser: false, message: response.text ?? "", date: DateTime.now()));
    });

    // Clear the input field
    _userInput.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
          title: Text(
          'MediMate',
          style:TextStyle(fontSize: 50,fontWeight:FontWeight.w300)),
      ),
   // backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
                image:AssetImage("assets/medimatewallpaper.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: ListView.builder(itemCount:_messages.length,itemBuilder: (context,index){
                  final message = _messages[index];
                  return Messages(isUser: message.isUser, message: message.message, date: DateFormat('HH:mm').format(message.date));
                })
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _userInput,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          label: Text('Enter Your Message')
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.all(12),
                      iconSize: 30,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(CircleBorder())
                      ),
                      onPressed: (){
                        sendMessage();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}