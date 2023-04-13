import 'package:flutter/material.dart';
import 'package:fyp/core/widgets/drawer.dart';

class HackSquat extends StatelessWidget {
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
                              image: AssetImage('images/hacksquat.gif'),
                              fit: BoxFit.fill))),
                  Container(
                    child: Text("How to perform hack squat?",
                        style: TextStyle(
                          fontFamily: "SanFranciscos",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Load the machine with your desired amount of weight. As a beginner, it’s recommended to get familiar with the movement of the machine before adding a bunch of plates. ",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Step into the machine, placing your feet shoulder-width apart and your shoulders and back against the pads.",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Release the safety handles, inhale, and lower down, bending your knees until they reach a 90-degree angl. ",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Pause here, then push up through the back of your feet to extend your legs back to the starting position..",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                ]),
              ),
            )));
  }
}
