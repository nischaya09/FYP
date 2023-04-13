import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UI22 extends StatefulWidget {
  @override
  _UI22State createState() => _UI22State();
}

class _UI22State extends State<UI22> {
  static const values = <String>[
    'Login Trouble',
    'Phone Number Related',
    'Personal Profile',
    'Other Issues',
    'Suggestions'
  ];
  String selectedValue = values.first;
  final _formkey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();

  String token = '';
  String refresh = '';
  bool loading = false;

  Future gettoken() async {
    String? jwt = await storage.read(key: "token");
    String? refresh = await storage.read(key: "refresh");
    if (jwt != null) {
      setState(() {
        token = jwt;
        this.refresh = refresh!;
      });
    } else {
      setState(() {
        token = "Gym";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gettoken();
  }

  Future sendFeedback(String feeedback, String title) async {
    final response = await http.post(
      Uri.parse("http://192.168.10.132:8000/api/feedback/add/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{'feed': feeedback, 'type': title}),
    );
    if (response.statusCode == 201) {
      message(context, "Feedback posted successfully !! ");
      setState(() {
        loading = false;
        feedback.clear();
      });
    } else {
      setState(() {
        loading = false;
      });
      throw message(context, "Unable to post feedback");
    }
  }

  message(BuildContext context, String message) {
    showAlertDialog(context, message);
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        message,
        style: TextStyle(color: Colors.blue),
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
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final feedback = TextEditingController();
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                icon: Image.asset(
                  'images/drawer.png',
                  color: Colors.white,
                  height: 20,
                ),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                }),
            backgroundColor: Colors.black,
            title: Text(
              "Feedback",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "SanFranciscos",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/board.jpg'),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Please select the type of the feedback",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 25.0),
                    Column(
                      children: values.map((value) {
                        return RadioListTile<String>(
                            value: value,
                            title: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            groupValue: selectedValue,
                            onChanged: (value) => setState(() {
                                  this.selectedValue = value!;
                                }));
                      }).toList(),
                    ),
                    buildFeedbackForm(),
                    SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          sendFeedback(feedback.text, selectedValue);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: loading == false
                                ? const Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  buildFeedbackForm() {
    return Container(
      child: Form(
        key: _formkey,
        child: TextFormField(
          maxLines: 10,
          controller: feedback,
          validator: (value) {
            if (value!.isEmpty) {
              return "Plese enter something.";
            } else
              null;
          },
          decoration: InputDecoration(
              fillColor: Colors.white60,
              filled: true,
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
              hintText: "Please briefly describe the issue",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
  }
}
