import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_page.dart'; // Import the login page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB-uozXZzz9pahfODpgYPUDzNjtxmwb0yw",
          appId: "1:452451009716:android:4fb2709f24f65b26ccc3e1",
          messagingSenderId: "452451009716",
          projectId: "crest-f82e8"));
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
