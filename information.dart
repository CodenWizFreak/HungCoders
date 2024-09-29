import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});
  @override
  State<InformationPage> createState() => _InformationPage();
}

class _InformationPage extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About CREST'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome to CREST!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'CREST is a unique music app that not only allows you to stream your favorite songs but also connect with people who share your music taste.',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                'Key Features:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.music_note, color: Colors.blueAccent),
                title: Text(
                    'Stream millions of songs from your favorite artists.'),
              ),
              ListTile(
                leading: Icon(Icons.chat, color: Colors.blueAccent),
                title: Text('Chat with people who love the same music.'),
              ),
              ListTile(
                leading: Icon(Icons.ad_units, color: Colors.blueAccent),
                title: Text('Only banner ads, no video ads for free users.'),
              ),
              ListTile(
                leading: Icon(Icons.upgrade, color: Colors.blueAccent),
                title: Text(
                    'Upgrade to Premium for Rs 49/month to remove all banner ads.'),
              ),
              SizedBox(height: 20),
              Text(
                'Premium Benefits:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading:
                    Icon(Icons.remove_circle_outline, color: Colors.blueAccent),
                title: Text('No banner ads. Enjoy an ad-free experience.'),
              ),
              ListTile(
                leading: Icon(Icons.high_quality, color: Colors.blueAccent),
                title: Text('Exclusive access to high-quality audio streams.'),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle premium upgrade logic here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.orangeAccent,
                    // primary: Colors.blueAccent,
                  ),
                  child: Text(
                    'Upgrade to Premium for Rs 49',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Thank you for choosing CREST!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
