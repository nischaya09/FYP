import 'dart:convert';
import 'package:fyp/feature/forgetPassword/views/enter_email_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/feature/login/views/login.dart';

class ResetPassword extends StatefulWidget {
  final String otp;
  const ResetPassword({Key? key, required this.otp}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  void changePassword(String password) async {
    final response = await http.post(
        Uri.parse("http://192.168.10.82:8000/api/user/newpassword/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"otp": widget.otp, "password": password}));
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Mylogin()));
      Fluttertoast.showToast(
          msg: "Password Changed Sucessfully",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EnterEmailPage()));
      Fluttertoast.showToast(
          msg: jsonDecode(response.body)["message"],
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15);
    }
  }

  checkPassword(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      if (pass1.text == pass2.text) {
        setState(() {
          loading = true;
        });
        changePassword(pass1.text);
      } else {
        Fluttertoast.showToast(
            msg: "Password Mismatch",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15);
      }
    }
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
                          "Enter new password",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                  obscureText: true,
                                  controller: pass1,
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
                                      hintText: "Password",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)))),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  obscureText: true,
                                  controller: pass2,
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
                                      hintText: "Re-Password",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0, primary: Colors.black),
                            onPressed: () {
                              checkPassword(context);
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
