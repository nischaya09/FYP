import 'package:flutter/material.dart';
import 'package:fyp/core/widgets/drawer.dart';

class Squat extends StatelessWidget {
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
                        'Programs',
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
              padding: EdgeInsets.only(top: 80),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/squat.gif'),
                              fit: BoxFit.fill))),
                  Container(
                    child: Text("How to perform squat?",
                        style: TextStyle(
                          fontFamily: "SanFranciscos",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 0, top: 10, right: 190),
                      child: Text(" Don’t drop your chin ",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 0, top: 10, right: 210),
                      child: Text("Get your chest up",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 0, top: 10, right: 180),
                      child: Text(" Push elbows forwards ",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 150),
                      child: Text("Keep knees in line with toes",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 0, top: 10, right: 200),
                      child: Text(" Heels flat on the floor",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                ]),
              ),
            )));
  }
}
