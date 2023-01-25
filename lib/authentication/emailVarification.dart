import 'package:flutter/material.dart';

class EmailVafication extends StatelessWidget {
  const EmailVafication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController verificationController = TextEditingController();
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
                  onPressed: () {},
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
