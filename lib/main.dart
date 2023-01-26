import 'package:flutter/material.dart';

import 'authentication/account_signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean-Soil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUp(),
    );
  }
}
