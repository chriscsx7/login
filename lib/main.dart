import 'package:flutter/material.dart';
import 'package:login/screen/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Flutterfire',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: SignInScreen(),
    );
  }
}