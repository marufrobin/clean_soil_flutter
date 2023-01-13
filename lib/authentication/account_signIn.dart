import 'package:flutter/material.dart';

class AccountSignInPage extends StatefulWidget with ValidationMixin {
  AccountSignInPage({Key? key}) : super(key: key);

  @override
  State<AccountSignInPage> createState() => _AccountSignInPageState();
}

class _AccountSignInPageState extends State<AccountSignInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Use your work email to login",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    fontFamily: "SFPro"),
              ),
              SizedBox(
                height: 32,
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
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
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
                  )),
            ],
          ),
        ),
      ),
    ));
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
