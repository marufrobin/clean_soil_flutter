// ignore_for_file: prefer_const_constructors, unused_import

import 'package:clean_soil_flutter/authentication/onboarding.dart';
import 'package:clean_soil_flutter/construction_screen/dashboard.dart';
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

      // home: OnboardingScreen(),

      home: DashboardScreen(),
    );
  }
}
