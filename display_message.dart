import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayMessage extends StatefulWidget {
  final String name;
  const DisplayMessage({super.key, required this.name});

  @override
  State<DisplayMessage> createState() => _DisplayMessageState();
}

class _DisplayMessageState extends State<DisplayMessage> {
  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection("Message")
      .orderBy('time')
      .snapshots();
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _messageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Somethings went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              primary: true,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot qds = snapshot.data!.docs[index];
                Timestamp time = qds['time'];
                DateTime dateTime = time.toDate();
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    crossAxisAlignment: widget.name == qds['name']
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.purple,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          title: Text(
                            qds['name'],
                            style: TextStyle(
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
                                  qds["message"],
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
              });
        });
  }
}
