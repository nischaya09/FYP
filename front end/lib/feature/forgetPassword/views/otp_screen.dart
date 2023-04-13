import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fyp/feature/forgetPassword/views/enter_email_screen.dart';
import 'package:fyp/feature/forgetPassword/views/reset_password.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otp = TextEditingController();

  bool loading = true;

  void changePassword(BuildContext context, String code) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => ResetPassword(otp: code)),
    );
  }

  Future sendotp() async {
    final response = await http.post(
        Uri.parse("http://192.168.10.82:8000/api/user/sendotp/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": widget.email,
        }));
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(
          msg: "otp sent successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15);
    } else {
      Navigator.pop(context);
      FocusScopeNode currentFocus = FocusScope.of(context);
      currentFocus.unfocus();
      Fluttertoast.showToast(
          msg: "Invalid email",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendotp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: (loading == false)
              ? Container(
                  width: double.infinity,
                  color: Colors.white12,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          "Enter OTP",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Form(
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: otp,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Field cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.white60,
                                  filled: true,
                                  hintText: "OTP",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0, primary: Colors.black),
                            onPressed: () {
                              changePassword(context, otp.text);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text("Proceed"),
                            )),
                        Spacer()
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
