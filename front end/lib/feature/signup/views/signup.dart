import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fyp/feature/login/views/login.dart';
import 'package:http/http.dart' as http;

class MySignup extends StatefulWidget {
  const MySignup({Key? key}) : super(key: key);

  @override
  _MySignupState createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
  final storage = FlutterSecureStorage();
  final _formkey = GlobalKey<FormState>();
  final fname = TextEditingController();
  final lname = TextEditingController();
  final email = TextEditingController();
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();
  bool isChecked = true;
  bool loading = false;

  Future userRegister(
      String fname, String lname, String email, String password) async {
    final response = await http.post(
      Uri.parse("http://192.168.10.132:8000/api/user/register/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'first_name': fname,
        'last_name': lname,
        'email': email,
        'password': password
      }),
    );
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Mylogin()), (route) => false);
    } else {
      setState(() {
        loading = false;
      });
      throw error(context, "unable to register");
    }
  }

  error(BuildContext context, String message) {
    showAlertDialog(context, message);
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        message,
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

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.blue;
    }

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/rad.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: (loading == false)
            ? Stack(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 80, top: 120, bottom: 50),
                    child: const Text(
                      'RAD RIDES',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.3,
                          right: 25,
                          left: 25),
                      child: Form(
                        key: _formkey,
                        child: Column(children: [
                          Row(children: [
                            Expanded(
                              child: TextFormField(
                                  controller: fname,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name field cannot be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white60,
                                      filled: true,
                                      hintText: "Firstname",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)))),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextFormField(
                                    controller: lname,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Last name cannot be empty";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        fillColor: Colors.white60,
                                        filled: true,
                                        hintText: "Lastname",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))))),
                          ]),
                          const SizedBox(
                            //to create gap between emailbox and password box//
                            height: 20,
                          ),
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
                              hintText: "Email Address",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            //to create gap between emailbox and password box//
                            height: 20,
                          ),
                          TextFormField(
                            controller: pass1,
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
                            //to create gap between emailbox and password box//
                            height: 20,
                          ),
                          TextFormField(
                            controller: pass2,
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
                              hintText: "Confirm-Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            Text(
                              'I accept terms and privacy policy ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 15, 20),
                              child: Text(
                                'Click here to learn about Terms and condition',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                  width: 200,
                                  padding: EdgeInsets.fromLTRB(100, 0, 0, 10),
                                  child: ElevatedButton(child: Text("Sign up",
                                       style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                      borderRadius:
                                     BorderRadius.circular(18.0),
                                   side: BorderSide()),),
                               onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                     if (pass1.text == pass2.text) {
                                         setState(() {
                                           loading = true;
                                        });
                                           userRegister(fname.text, lname.text,
                                               email.text, pass1.text);
                                        } else {
                                          throw error(
                                               context, "password mis-match");
                                         }
                                       }
                               },
                                ),
                                  // child: RaisedButton(
                                  //   color: Colors.black,
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius:
                                  //           BorderRadius.circular(18.0),
                                  //       side: BorderSide()),
                                  //   onPressed: () {
                                  //     if (_formkey.currentState!.validate()) {
                                  //       if (pass1.text == pass2.text) {
                                  //         setState(() {
                                  //           loading = true;
                                  //         });
                                  //         userRegister(fname.text, lname.text,
                                  //             email.text, pass1.text);
                                  //       } else {
                                  //         throw error(
                                  //             context, "password mis-match");
                                  //       }
                                  //     }
                                  //   },
                                  //   padding: EdgeInsets.all(10.0),
                                  //   textColor: Color(0xff4c505b),
                                  //   child: Text("Sign up",
                                  //       style: TextStyle(
                                  //           fontSize: 15, color: Colors.white)),
                                  // )
                                  ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(60, 0, 30, 10),
                                  child: Text(
                                    'Already have account, Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  )
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
