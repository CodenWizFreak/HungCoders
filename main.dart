import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_page.dart'; // Import the login page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "",
          appId: "",
          messagingSenderId: "",
          projectId: ""));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // Set LoginPage as the home screen
    );
  }
}

//App A
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((token) {
      print("App A Firebase Token: $token");
    });
  }

  // Send a message to App B (via Firebase Cloud Messaging)
  Future<void> sendMessageToAppB() async {
    // Implement your API call or Firebase function here to send the message.
    // Example method (just placeholder for demonstration):
    print('Sending message to App B...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App A')),
      body: Center(
        child: ElevatedButton(
          onPressed: sendMessageToAppB,
          child: Text('Send message to App B'),
        ),
      ),
    );
  }
}

