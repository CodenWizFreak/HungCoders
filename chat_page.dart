import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'display_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String userName = 'Anonymous'; // Default name if none is provided

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: Colors.blueAccent,
            onPressed: () {},
            child: const Text(
              "Exit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child:
                  DisplayMessage(name: userName), // Pass the user-entered name
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Enter your name",
                      enabled: true,
                      contentPadding:
                          const EdgeInsets.only(left: 15, bottom: 8, top: 8),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userName = value.isNotEmpty ? value : 'Anonymous';
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Message",
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 15, bottom: 8, top: 8),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (messageController.text.isNotEmpty) {
                            firebaseFirestore.collection("Message").doc().set({
                              'message': messageController.text.trim(),
                              'time': DateTime.now(),
                              'senderName':
                                  userName, // Use user name from the text field
                            });
                            messageController.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send_sharp,
                          size: 30,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
