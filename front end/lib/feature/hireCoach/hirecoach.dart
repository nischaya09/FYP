import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fyp/core/widgets/drawer.dart';
import 'package:fyp/modals/coach.dart';
import 'package:http/http.dart' as http;

class HireCoach extends StatefulWidget {
  @override
  _HireCoachState createState() => _HireCoachState();
}

class _HireCoachState extends State<HireCoach> {
  late Future<List<CoachModal>> futurePrograms;
  final storage = new FlutterSecureStorage();

  String token = '';
  String refresh = '';

  Future gettoken() async {
    String? jwt = await storage.read(key: "token");
    String? refresh = await storage.read(key: "refresh");
    if (jwt != null) {
      setState(() {
        token = jwt;
        this.refresh = refresh!;
      });
      futurePrograms = displayCoach();
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

  Future<List<CoachModal>> displayCoach() async {
    final response = await http.get(
      Uri.parse("http://192.168.10.132:8000/api/coach/all/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => CoachModal.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load coach');
    }
  }

  hireCoach(int id) async {
    final response = await http.post(
      Uri.parse("http://192.168.10.82:8000/api/coach/hire/${id}/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 201) {
      message(context, "Coach hired successfully");
    } else {
      throw message(context, "Failed : Coach hire");
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Image.asset(
                'images/drawer.png',
                color: Colors.white,
                height: 20,
              ),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              }),
          backgroundColor: Colors.black,
          title: const Text(
            'Fit Nepal',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "SanFranciscos",
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        drawer: MainDrawer(),
        body: FutureBuilder<List<CoachModal>>(
            future: displayCoach(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CoachModal> data = snapshot.data!;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              child: ClipOval(
                                child: Image.network(
                                  data[index].image,
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              data[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              Icon(Icons.email),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                data[index].email,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ]),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(children: const [
                              Icon(Icons.perm_identity_outlined),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'C2',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ]),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              Icon(Icons.phone_android),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                data[index].phone,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ]),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                hireCoach(data[index].id);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0, vertical: 16),
                                  child: Text(
                                    "Hire ME",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
