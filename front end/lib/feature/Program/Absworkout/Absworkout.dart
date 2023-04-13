import 'package:flutter/material.dart';
import 'package:fyp/core/widgets/drawer.dart';

class AbsWorkout extends StatefulWidget {
  @override
  _AbsWorkoutState createState() => _AbsWorkoutState();
}

class _AbsWorkoutState extends State<AbsWorkout> {
  @override
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                leading: IconButton(
                    padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
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
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 100, 0),
                      child: Text(
                        'Abs Workout',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SanFranciscos",
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            extendBodyBehindAppBar: true,
            drawer: MainDrawer(),
            body: Container(
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Stack(children: [
                      SingleChildScrollView(
                          child: Column(children: [
                        Container(
                            color: Colors.white.withOpacity(0.5),
                            padding: EdgeInsets.fromLTRB(10, 120, 0, 0),
                            child: Row(children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                  child: Image.asset(
                                    'images/hacksquat.jpg',
                                    height: 70,
                                  )),
                              Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                  child: TextButton(
                                      child: Text('Hack Squat',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "SanFranciscos",
                                            fontSize: 25,
                                          )),
                                      onPressed: () {})),
                            ])),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Container(
                            color: Colors.white.withOpacity(0.5),
                            padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                            child: Row(children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Image.asset(
                                  'images/legcurl.jpg',
                                  height: 90,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                                  child: TextButton(
                                    child: Text('Leg Curl',
                                        style: TextStyle(
                                          fontFamily: "SanFranciscos",
                                          fontSize: 25,
                                        )),
                                    onPressed: () {},
                                  )),
                            ])),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Container(
                            color: Colors.white.withOpacity(0.5),
                            padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                            child: Row(children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Image.asset(
                                  'images/legextension.jpg',
                                  height: 70,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                  child: TextButton(
                                    child: Text('Leg Extension',
                                        style: TextStyle(
                                          fontFamily: "SanFranciscos",
                                          fontSize: 25,
                                        )),
                                    onPressed: () {},
                                  )),
                            ])),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Container(
                            color: Colors.white.withOpacity(0.5),
                            padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                            child: Row(children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Image.asset(
                                  'images/sumodeadlift.jpg',
                                  height: 70,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                  child: TextButton(
                                    child: Text('Sumo Deadlift',
                                        style: TextStyle(
                                          fontFamily: "SanFranciscos",
                                          fontSize: 25,
                                        )),
                                    onPressed: () {},
                                  )),
                            ])),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Container(
                            color: Colors.white.withOpacity(0.5),
                            padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                            child: Row(children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Image.asset(
                                  'images/squat.jpg',
                                  height: 90,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                  child: TextButton(
                                    child: Text('Squat',
                                        style: TextStyle(
                                          fontFamily: "SanFranciscos",
                                          fontSize: 25,
                                        )),
                                    onPressed: () {},
                                  )),
                            ])),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ]))
                    ])))));
  }
}
