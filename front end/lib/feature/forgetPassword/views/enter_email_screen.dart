import 'package:flutter/material.dart';
import 'package:fyp/feature/forgetPassword/views/otp_screen.dart';
import 'package:fyp/feature/forgetPassword/views/reset_password.dart';
import 'package:fyp/feature/login/views/login.dart';

class EnterEmailPage extends StatefulWidget {
  const EnterEmailPage({Key? key}) : super(key: key);

  @override
  State<EnterEmailPage> createState() => _EnterEmailPageState();
}

class _EnterEmailPageState extends State<EnterEmailPage> {
  final email = TextEditingController();

  void sendotp(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => OTPScreen(
                email: email.text,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        color: Colors.white12,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Spacer(),
              Text(
                "Enter your email",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                child: TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email field cannot be empty";
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return "check your email";
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        hintText: "Email Adress",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)))),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: Colors.black),
                  onPressed: () {
                    sendotp(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Proceed"),
                  )),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mylogin()));
                },
                child: Text("Go to Login "),
              ),
              Spacer()
            ],
          ),
        ),
      )),
    );
  }
}
