import 'dart:convert';

import 'package:clean_soil_flutter/authentication/account_signIn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";

  adminRegistration() async {
    var adminRegUrl = "auth/company-admin/admin-register";
    Map map = Map<String, dynamic>();
    map["companyType"] = "construction";
    map["companyName"] = "cleansoil";
    map["fullName"] = nameController.text.toString();
    map["workEmail"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    var responce = await http.post(
        Uri.parse("$baseUrl$apiVersionUrl$adminRegUrl"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(map));
    print("printinnnngnng mapppppppp: $map");
    print("Resspoceeeeeeeeeeeeee from api:::${responce.body}");
  }

  sendVerficationCode() async {
    String adminSendVerfCodeUrl = "/api/v1/auth/company-admin/admin-send-code";
    Map bodyMap = Map<String, dynamic>();
    bodyMap["email"] = emailController.text.toString();
    var responce = await http.post(
      Uri.parse("$baseUrl$apiVersionUrl$adminSendVerfCodeUrl"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(bodyMap),
    );
    print("verification code send api hiiititiitit:: ${responce.body}");
  }

  @override
  void initState() {
    // TODO: implement initState
    // adminRegistration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 1.00,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Use your work email to signup",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      fontFamily: "SFPro"),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "Name",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: "SFPro"),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "name is empty";
                    }
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Jane Doe",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xffACACAC),
                          fontFamily: "SFPro"),
                      labelStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                ),
                SizedBox(
                  height: 8,
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "email is empty";
                    }
                    if (!value.contains("@")) {
                      return "email feild requred";
                    }
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "aerfan.work@gmail.com",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xffACACAC),
                          fontFamily: "SFPro"),
                      labelStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                      )),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password is empty";
                    }
                    if (value.length < 3) {
                      return "password is too short";
                    }
                    if (value.length > 8) {
                      return "password is too Long";
                    }
                  },
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  obscureText: isObsecure,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xffACACAC),
                        fontFamily: "SFPro"),
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                        icon: isObsecure
                            ? Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                            : Image.asset("images/eye.png")),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE1E1E1)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xffE1E1E1)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Confirm password",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: "SFPro"),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Confirm password is empty";
                    }
                    if (value.length < 3) {
                      return " Confirm password is too short";
                    }
                    if (value.length > 8) {
                      return " Confirm password is too Long";
                    }
                  },
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  obscureText: isObsecure2,
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xffACACAC),
                        fontFamily: "SFPro"),
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObsecure2 = !isObsecure2;
                          });
                        },
                        icon: isObsecure2
                            ? Icon(
                                Icons.visibility_off,
                              )
                            : Image.asset("images/eye.png")),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xffE1E1E1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xffE1E1E1)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "name is empty";
                    }
                  },
                  // controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Select Position",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff0086F0),
                          fontFamily: "SFPro"),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                ),
                Spacer(),
                ElevatedButton(
                    style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {
                      adminRegistration();
                      print("Sign up button clickkkkkkkkkkkkk");
                      sendVerficationCode();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 116),
                      child: Center(
                        child: Text(
                          "Signup",
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
                    style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      side: MaterialStatePropertyAll(BorderSide(
                        color: Color(0xffC7E0F4),
                        width: 1,
                      )),
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountSignInPage(),
                          ));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 116),
                      child: Center(
                        child: Text(
                          "Alredy have your account? Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.blue,
                              fontFamily: "SFPro"),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isObsecure = true;
  bool isObsecure2 = true;
}
