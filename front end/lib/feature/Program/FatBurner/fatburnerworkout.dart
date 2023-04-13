import 'package:flutter/material.dart';

import 'package:fyp/core/widgets/drawer.dart';
import 'package:fyp/feature/Program/FatBurner/Burpees.dart';
import 'package:fyp/feature/Program/FatBurner/Jumpingjack.dart';
import 'package:fyp/feature/Program/FatBurner/climbers.dart';
import 'package:fyp/feature/Program/FatBurner/highknees.dart';
import 'package:fyp/feature/Program/FatBurner/skipping.dart';

class FatBurnerWorkout extends StatefulWidget {
  @override
  _FatBurnerWorkoutState createState() => _FatBurnerWorkoutState();
}

class _FatBurnerWorkoutState extends State<FatBurnerWorkout> {
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
                        'Fat Burner Workout',
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
                                    'images/burpees.jpg',
                                    height: 70,
                                  )),
                              Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                  child: TextButton(
                                    child: Text('Burpees',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "SanFranciscos",
                                          fontSize: 25,
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Burpees()),
                                      );
                                    },
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
                                  'images/highknees.jpg',
                                  height: 90,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                                  child: TextButton(
                                    child: Text('High Knees',
                                        style: TextStyle(
                                          fontFamily: "SanFranciscos",
                                          fontSize: 25,
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Highknees()),
                                      );
                                    },
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
                                  'images/jumpingjacks.jpg',
                                  height: 70,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                  child: TextButton(
                                    child: Text('Jumping Jacks',
                                        style: TextStyle(
                                          fontFamily: "SanFranciscos",
                                          fontSize: 25,
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JumpingJacks()),
                                      );
                                    },
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
                                  'images/moutainclimbers.jpg',
                                  height: 70,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                  child: TextButton(
                                    child: Text('Climbers',
                                        style: TextStyle(
                                          fontFamily: "SanFranciscos",
                                          fontSize: 25,
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => climbers()),
                                      );
                                    },
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
                                  'images/skipping.jpg',
                                  height: 90,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                  child: TextButton(
                                    child: Text('Skipping',
                                        style: TextStyle(
                                          fontFamily: "SanFranciscos",
                                          fontSize: 25,
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Skipping()),
                                      );
                                    },
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
