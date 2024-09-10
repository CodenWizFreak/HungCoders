import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/chat/display_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageControler = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
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
              height: MediaQuery.of(context).size.height * 0.8,
              child: DisplayMessage(
                name: "Hello",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageControler,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Message",
                        enabled: true,
                        contentPadding:
                            EdgeInsets.only(left: 15, bottom: 8, top: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        messageControler.text = value!;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (messageControler.text.isNotEmpty) {
                        firebaseFirestore.collection("Message").doc().set({
                          'message': messageControler.text.trim(),
                          'time': DateTime.now(),
                        });
                        messageControler.clear();
                      }
                    },
                    icon: Icon(
                      Icons.send_sharp,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
