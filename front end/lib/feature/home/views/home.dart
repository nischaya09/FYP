import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/core/widgets/drawer.dart';
import 'package:fyp/feature/Feedback/feedback.dart';
import 'package:fyp/feature/Program/programs_screen.dart';
import 'package:fyp/feature/aboutus/aboutus.dart';
import 'package:fyp/feature/gymproducts/gymproducts.dart';
import 'package:fyp/feature/hireCoach/hirecoach.dart';
import 'package:fyp/feature/notifications/views/notification_screen.dart';
import 'package:fyp/widgets/listwidget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

ThemeData _lightTheme = ThemeData(
    accentColor: Colors.blue,
    brightness: Brightness.light,
    primaryColor: Colors.blue);
ThemeData _darkTheme = ThemeData(
    accentColor: Colors.red,
    brightness: Brightness.dark,
    primaryColor: Colors.amber);
bool _light = true;

class _HomePageState extends State<HomePage> {
  int count = 0;

  noti(Timer timer) async {
    final response = await http.get(
      Uri.parse("http://192.168.10.132:8000/api/notifications/count/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        count = jsonDecode(response.body)["number"];
      });
    } else {
      throw Exception("Failed");
    }
  }

  @override
  void initState() {
    super.initState();
    var _timer = new Timer.periodic(const Duration(seconds: 2), noti);
  }

  @override
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            leading: IconButton(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                icon: Image.asset(
                  'images/drawer.png',
                  color: Colors.white,
                  height: 40,
                ),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                }),
            backgroundColor: Colors.black,
            actions: <Widget>[
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 100, 0),
                  child: const Text(
                    'RAD RIDES',
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "SanFranciscos",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 23, 0, 0),
                  child: Switch(
                      value: _light,
                      onChanged: (state) {
                        setState(() {
                          _light = state;
                        });
                      }))
            ],
          ),
        ),
        // extendBodyBehindAppBar: true,
        drawer: MainDrawer(),
        body: Container(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Programs()),
                    );
                  },
                  child: const ListWidgets(
                    img: 'images/mtb.png',
                    title: 'Programs',
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                const ListWidgets(
                  img: 'images/notes.png',
                  title: 'Note Exercise',
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                const ListWidgets(
                  img: 'images/download.png',
                  title: 'Download plans',
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HireCoach()),
                    );
                  },
                  child: const ListWidgets(
                    img: 'images/man.png',
                    title: 'Coach Hire',
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GymProducts()),
                    );
                  },
                  child: const ListWidgets(
                    img: 'images/bar-chart.png',
                    title: ' Product',
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                            child: Image.asset(
                              'images/notification.jpg',
                              height: 50,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text('Notifications',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SanFranciscos",
                                fontSize: 25,
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        (count > 0)
                            ? CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                radius: 12,
                                child: Text(count.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              )
                            : Text(""),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    )),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                const ListWidgets(
                  img: 'images/healthfacts.png',
                  title: 'Health Facts',
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Contact()),
                    );
                  },
                  child: const ListWidgets(
                    img: 'images/user.png',
                    title: 'About us',
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UI22()),
                    );
                  },
                  child: const ListWidgets(
                    img: 'images/feedback.jpg',
                    title: 'Feedback',
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ListWidgets extends StatelessWidget {
  final title;
  final img;
  const ListWidgets({
    Key? key,
    required this.title,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
            child: Image.asset(
              img,
              height: 50,
            )),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: Text(title,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "SanFranciscos",
                  fontSize: 25,
                )))
      ],
    );
  }
}
