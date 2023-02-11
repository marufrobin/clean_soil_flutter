// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'account_signIn.dart';

class EmailVafication extends StatefulWidget {
  EmailVafication({Key? key, this.emailFFF}) : super(key: key);
  var emailFFF;

  @override
  State<EmailVafication> createState() => _EmailVaficationState();
}

class _EmailVaficationState extends State<EmailVafication> {
  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";
  sendVerficationCode() async {
    String adminSendVerfCodeUrl = "auth/user/send-code";
    Map bodyMap = Map<String, dynamic>();
    bodyMap["email"] = widget.emailFFF;
    var responce = await http.post(
      Uri.parse("$baseUrl$apiVersionUrl$adminSendVerfCodeUrl"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(bodyMap),
    );
    print("verification code send api hiiititiitit:: ${responce.body}");
  }

  @override
  void initState() {
    sendVerficationCode();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController verificationController = TextEditingController();

    adminVerifyCode() async {
      var adminVerCodeUrl = "auth/user/verify-code";
      Map map = Map<String, dynamic>();

      map["email"] = widget.emailFFF;
      map["code"] = verificationController.text.toString();
      var responce = await http.post(
          Uri.parse("$baseUrl$apiVersionUrl$adminVerCodeUrl"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(map));
      print("printinnnngnng mapppppppp: $map");
      print("Resspoceeeeeeeeeeeeee from api:::${responce.body}");
      print("Statussssss codeeeee from api:::${responce.statusCode}");
      var suc = jsonDecode(responce.body)["success"];
      print(suc);
      if (responce.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AccountSignInPage(),
            ),
            (route) => false);
        Fluttertoast.showToast(
            msg: "Code Verfied Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "${suc}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We have send you a code to verify your email address",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    fontFamily: "SFPro"),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Verification code",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    fontFamily: "SFPro"),
              ),
              SizedBox(
                height: 4,
              ),
              TextField(
                controller: verificationController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE1E1E1)),
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "AQ73ZV",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xffACACAC),
                        fontFamily: "SFPro")),
              ),
              Spacer(),
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
                  onPressed: () {
                    sendVerficationCode();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    child: Center(
                      child: Text(
                        "Resend Code",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color(0xff0078D4),
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
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xff0078D4)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  onPressed: () {
                    adminVerifyCode();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    child: Center(
                      child: Text(
                        "Verify email",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: "SFPro"),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
