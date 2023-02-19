// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:clean_soil_flutter/authentication/account_signup.dart';
import 'package:clean_soil_flutter/constans/constans.dart';
import 'package:clean_soil_flutter/model/shared_preference.dart';
import 'package:clean_soil_flutter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../construction_screen/dashboard.dart';

class AccountSignInPage extends StatefulWidget with ValidationMixin {
  AccountSignInPage({Key? key}) : super(key: key);

  @override
  State<AccountSignInPage> createState() => _AccountSignInPageState();
}

class _AccountSignInPageState extends State<AccountSignInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";
  User user = User();

  adminLogin() async {
    var adminLogUrl = "auth/user/login";
    Map map = <String, dynamic>{};

    map["username"] = emailController.text.toString();

    map["password"] = passwordController.text.toString();
    var responce = await http.post(
        Uri.parse("$baseUrl$apiVersionUrl$adminLogUrl"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(map));
    print("printinnnngnng mapppppppp: $map");
    print("Resspoceeeeeeeeeeeeee from api:::${responce.body}");
    var suc = jsonDecode(responce.body)["success"];
    var data = jsonDecode(responce.body)["data"];
    print(suc);
    if (responce.statusCode == 200 && suc == true) {
      user.userId = data["_id"];
      user.userEmail = data["email"];
      user.userFullName = data["fullName"];
      user.comapanyType = data["userCompanyType"];
      user.companyId = data["companyId"];
      user.userPosition = data["userPosition"];
      /* print("user id: ${user.userId}");
      print("user email: ${user.userEmail}");
      print("user fullName: ${user.userFullName}");
      print("user Company type: ${user.comapanyType}");

      print("user position: ${user.userPosition}");*/
      await SharedPreference.addStringToSP(userId, user.userId);
      await SharedPreference.addStringToSP(userEmail, user.userEmail);
      await SharedPreference.addStringToSP(userName, user.userFullName);
      await SharedPreference.addStringToSP(userCompanyType, user.comapanyType);
      await SharedPreference.addStringToSP(usercompanyId, user.companyId);
      await SharedPreference.addStringToSP(userPosition, user.userPosition);

      print("user id: ${await SharedPreference.getStringValueSP(userId)}");
      print(
          "user email: ${await SharedPreference.getStringValueSP(userEmail)}");
      print(
          "user fullName: ${await SharedPreference.getStringValueSP(userName)}");
      print(
          "user Company type: ${await SharedPreference.getStringValueSP(userCompanyType)}");

      print(
          "user position: ${await SharedPreference.getStringValueSP(userPosition)}");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DashboardScreen(userCompanyType: user.comapanyType!),
          ),
          (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: "${jsonDecode(responce.body)["message"]}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.all(26),
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                Text(
                  "Email",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: "SFPro"),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (email) {
                    if (widget.isEmailValid(email!)) {
                      return null;
                    } else
                      return 'Enter a valid email address';
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xffACACAC),
                          fontFamily: "SFPro")),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: "SFPro"),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: isObscureText,
                  validator: (password) {
                    if (widget.isPasswordValid(password!)) {
                      return null;
                    } else {
                      return 'Enter a valid password';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.circular(8)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              setState(() {
                                isObscureText = !isObscureText;
                              });
                            });
                          },
                          icon: isObscureText == true
                              ? Icon(Icons.visibility_off_rounded)
                              : Image.asset("images/eye.png"),
                          color: Colors.grey),
                      hintText: "Password",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xffACACAC),
                          fontFamily: "SFPro")),
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xff0078D4)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                      adminLogin();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "SFPro"),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      side: MaterialStatePropertyAll(BorderSide(
                        color: Color(0xffC7E0F4),
                        width: 1,
                      )),
                    ),
                    //Sign UP Button navigator
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountSignUpPage(
                              companyType: user.comapanyType,
                            ),
                          ));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 116),
                      child: Center(
                        child: Text(
                          "Don’t have an account? Signup",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xff0078D4),
                              fontFamily: "SFPro"),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isObscureText = true;
}

mixin ValidationMixin {
  bool isPasswordValid(String password) => password.length >= 4;

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
