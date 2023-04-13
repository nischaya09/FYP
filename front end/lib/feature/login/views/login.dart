import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fyp/feature/home/views/home.dart';
import 'package:fyp/feature/forgetPassword/views/enter_email_screen.dart';
import 'package:fyp/feature/signup/views/signup.dart';
import 'package:http/http.dart' as http;

class Mylogin extends StatefulWidget {
  const Mylogin({Key? key}) : super(key: key);

  @override
  _MyloginState createState() => _MyloginState();
}

class _MyloginState extends State<Mylogin> {
  final _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pwd = TextEditingController();
  final storage = FlutterSecureStorage();
  bool _loading = false;

  Future userLogin(String email, String password) async {
    final response = await http.post(
      Uri.parse("http://192.168.10.132:8000/api/user/login/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      settoken(decode["access"], decode["refresh"]);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } else {
      throw error(context);
    }
  }

  error(BuildContext context) {
    showAlertDialog(context);
    setState(() {
      _loading = false;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        "Invalid Email or Password.",
        style: TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  settoken(String jwt, String refresh) async {
    await storage.write(key: "token", value: jwt);
    await storage.write(key: "refresh", value: refresh);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: Container(
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/rad.jpg'), fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30, top: 150),
              child: const Text(
                'RAD RIDES',
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  right: 25,
                  left: 25),
              child: Form(
                key: _formkey,
                child: Column(children: [
                  TextFormField(
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
                  const SizedBox(
                    //to create gap between emailbox and password box//
                    height: 20,
                  ),
                  TextFormField(
                    controller: pwd,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password field cannot be empty";
                      } else if (value.length < 7) {
                        return "Password must be atleast 7 characters";
                      }
                      return null;
                    },
                    obscureText:
                        true, //this property helps to hide those letters while typing in password
                    decoration: InputDecoration(
                      fillColor: Colors.white60,
                      filled: true,
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EnterEmailPage()));
                    },
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forget password?',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(child: (_loading == false)
                        ? Text("Login",
                            style: TextStyle(fontSize: 15, color: Colors.white))
                        : CircularProgressIndicator(),
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(),
                               ),),
                               onPressed: () {
                                 setState(() {
                                                             _loading = true;

                                 });
                                 userLogin(email.text, pwd.text);
                               },
                                ),
                  // RaisedButton(
                  //   color: Colors.black,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(18.0),
                  //       side: BorderSide()),
                  //   onPressed: () {
                  //     if (_formkey.currentState!.validate()) {
                  //       setState(() {
                  //         _loading = true;
                  //       });
                  //       userLogin(email.text, pwd.text);
                  //     }
                  //   },
                  //   padding: EdgeInsets.all(10.0),
                  //   textColor: Color(0xff4c505b),
                  //   child: (_loading == false)
                  //       ? Text("Login",
                  //           style: TextStyle(fontSize: 15, color: Colors.white))
                  //       : CircularProgressIndicator(),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have no account ? ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MySignup()));
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    )));
  }
}
