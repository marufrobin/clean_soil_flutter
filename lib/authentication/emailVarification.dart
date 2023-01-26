import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmailVafication extends StatefulWidget {
  EmailVafication({Key? key, this.emailFFF}) : super(key: key);
  var emailFFF;

  @override
  State<EmailVafication> createState() => _EmailVaficationState();
}

class _EmailVaficationState extends State<EmailVafication> {
  @override
  Widget build(BuildContext context) {
    TextEditingController verificationController = TextEditingController();

    var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
    var apiVersionUrl = "api/v1/";

    adminVerifyCode() async {
      var adminVerCodeUrl = "auth/company-admin/admin-verify-code";
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
                  onPressed: () {},
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 116),
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
                    // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 116),
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
