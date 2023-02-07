// ignore_for_file: prefer_const_constructors

import 'package:clean_soil_flutter/authentication/account_signup.dart';
import 'package:clean_soil_flutter/model/user.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 76,
                right: 95,
                left: 95,
              ),
              child: Container(
                child: Image.asset('images/logo.png'),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Welcome to CleanSoil',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              fontFamily: 'SFPro'),
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select your account type to login or signup',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontFamily: 'SFPro'),
                        )),
                    SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                        style:
                            ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                        onPressed: () {
                          user.comapanyType = "Construction";
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AccountSignUpPage(
                                    companyType: user.comapanyType,
                                  )));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                              left: 20,
                            ),
                            child: Text(
                              "Construction",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  fontFamily: "SFPro"),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        style:
                            ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                        onPressed: () {
                          user.comapanyType = "Hauling";
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AccountSignUpPage(
                                    companyType: user.comapanyType,
                                  )));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                              left: 20,
                            ),
                            child: Text(
                              "Hauling",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  fontFamily: "SFPro"),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        style:
                            ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                        onPressed: () {
                          user.comapanyType = "Processor";
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AccountSignUpPage(
                                    companyType: user.comapanyType,
                                  )));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                              left: 20,
                            ),
                            child: Text(
                              "Processor",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  fontFamily: "SFPro"),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
