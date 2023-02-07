// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, dead_code

import 'dart:convert';

import 'package:clean_soil_flutter/authentication/emailVarification.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'account_signIn.dart';

class AccountSignUpPage extends StatefulWidget {
  AccountSignUpPage({super.key, required this.companyType});
  String? companyType;
  @override
  State<AccountSignUpPage> createState() => _AccountSignUpPageState();
}

class _AccountSignUpPageState extends State<AccountSignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";

  final List position = [
    'project co-ordinator',
    'driver',
  ];
  String? selectedValue;
  adminRegistration() async {
    var adminRegUrl = "auth/user/register";
    Map map = Map<String, dynamic>();

    map["fullName"] = nameController.text.toString();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    map["userCompanyType"] = widget.companyType;
    print("Company type ${widget.companyType}");
    print("Company type ${map["userCompanyType"]}");

    // need to implement filed from UI page
    map["userType"] = "cleansoil";

    map["userPosition"] = "project co-ordinator";
    map["status"] = "invited";
    var responce = await http.post(
        Uri.parse("$baseUrl$apiVersionUrl$adminRegUrl"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(map));
    print("printinnnngnng mapppppppp: $map");
    print("Resspoceeeeeeeeeeeeee from api:::${responce.body}");
  }

  sendVerficationCode() async {
    String adminSendVerfCodeUrl = "auth/user/send-code";
    Map bodyMap = Map<String, dynamic>();
    bodyMap["email"] = emailController.text.toString();
    var responce = await http.post(
      Uri.parse("$baseUrl$apiVersionUrl$adminSendVerfCodeUrl"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(bodyMap),
    );
    print("verification code send api hiiititiitit:: ${responce.body}");
    if (responce.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmailVafication(
              emailFFF: emailController.text,
            ),
          ));
    } else {
      print("Statusss code: ${responce.statusCode}");
    }
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
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            // padding: EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 1,
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
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
                        return "Password is Empty";
                        return null;
                      }
                      if (value.length < 6) {
                        return "The Password Requires 6 Characters Or More";
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                        borderRadius: BorderRadius.circular(8.0),
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
                        return null;
                      }
                      if (value.length < 6) {
                        return "The Password Requires 6 Characters Or More";
                      }
                      if (value != passwordController.text) {
                        return "Password Not Match";
                        return null;
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Select Your Position',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff0086F0),
                          fontFamily: "SFPro"),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    items: position
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Your Position';
                      }
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                  ),
                  Spacer(),
                  ElevatedButton(
                      style:
                          ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          adminRegistration();
                          print("Sign up button clickkkkkkkkkkkkk");
                          sendVerficationCode();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 116),
                        child: Center(
                          child: Text(
                            "SignUp",
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
                        // print("company type:::::${widget.companyType}");
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
                      )),
                  Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isObsecure = true;
  bool isObsecure2 = true;
}
