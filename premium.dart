import 'package:flutter/material.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});
  @override
  State<PremiumPage> createState() => _PremiumPage();
}

class _PremiumPage extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Go Premium with CREST'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.black,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Listen without limits.',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Try Premium for just ₹49/month.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Premium purchase logic goes here
                      },
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.white,
                        //onPrimary: Colors.black,
                        backgroundColor: Colors.orangeAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Text(
                        'GET PREMIUM FOR ₹49',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '₹49 per month. Cancel anytime.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Why join Premium?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading:
                    Icon(Icons.remove_circle_outline, color: Colors.blueAccent),
                title: Text('Ad-free music listening'),
              ),
              ListTile(
                leading: Icon(Icons.download, color: Colors.blueAccent),
                title: Text('Download songs to listen offline'),
              ),
              // ListTile(
              //   leading: Icon(Icons.shuffle, color: Colors.blueAccent),
              //   title: Text('Play songs in any order'),
              // ),
              ListTile(
                leading: Icon(Icons.high_quality, color: Colors.blueAccent),
                title: Text('High-quality audio streaming'),
              ),
              ListTile(
                leading: Icon(Icons.chat, color: Colors.blueAccent),
                title: Text('Chat with people who share your music taste'),
              ),
              ListTile(
                leading: Icon(Icons.people, color: Colors.blueAccent),
                title: Text('Exclusive premium chat rooms'),
              ),
              SizedBox(height: 20),
              Text(
                'Upgrade now and enjoy an ad-free, social music experience!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
