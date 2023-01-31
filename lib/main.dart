<<<<<<< HEAD
import 'package:clean_soil_flutter/authentication/account_signIn.dart';
=======
import 'package:clean_soil_flutter/authentication/account_signup.dart';
import 'package:clean_soil_flutter/construction_screen/dashboard.dart';
>>>>>>> 4f94cbf76fc91f53f84b4dae3a6a132090f76ade
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: AccountSignInPage(),
=======
      home: DashboardScreen(),
>>>>>>> 4f94cbf76fc91f53f84b4dae3a6a132090f76ade
    );
  }
}
