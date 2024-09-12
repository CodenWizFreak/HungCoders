import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayMessage extends StatefulWidget {
  final String name; // The user's name provided manually
  const DisplayMessage({super.key, required this.name});

  @override
  State<DisplayMessage> createState() => _DisplayMessageState();
}

class _DisplayMessageState extends State<DisplayMessage> {
  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection("Message")
      .orderBy('time')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No messages available"),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot qds = snapshot.data!.docs[index];
            Map<String, dynamic>? data = qds.data() as Map<String, dynamic>?;

            // Safely check if 'message', 'senderName', or 'time' exists
            String message = data?['message'] ?? 'No message';
            String senderName =
                data?['senderName'] ?? 'Unknown'; // Use senderName
            Timestamp? time = data?['time'] as Timestamp?;
            DateTime dateTime = time != null ? time.toDate() : DateTime.now();

            // Check if the message belongs to the current user
            bool isCurrentUser = widget.name == senderName;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isCurrentUser ? Colors.blue : Colors.purple,
                        ),
                        borderRadius: isCurrentUser
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                      ),
                      title: Text(
                        isCurrentUser
                            ? "You"
                            : senderName, // Display "You" for the sender
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              message,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text("${dateTime.hour}:${dateTime.minute}")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
