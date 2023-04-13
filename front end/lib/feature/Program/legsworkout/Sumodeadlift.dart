import 'package:flutter/material.dart';
import 'package:fyp/core/widgets/drawer.dart';

class SumoDeadlift extends StatelessWidget {
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
                              image: AssetImage('images/sumo-deadlift.gif'),
                              fit: BoxFit.fill))),
                  Container(
                    child: Text("How to perform sumo deadlift?",
                        style: TextStyle(
                          fontFamily: "SanFranciscos",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Foot placement: The main difference between the sumo deadlift and the conventional deadlift is the stance. When performing the sumo deadlift, your feet are placed wider than your shoulder width. ",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Unlike the conventional deadlift, where you place your hands wider than your knees, the sumo deadlift requires you to place your hands on the barbell between your knees.",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Range of motion: With its wider stance, the sumo deadlift variation has a shorter range of motion compared to the conventional deadlift. ",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "The longer lean forward of a conventional deadlift puts emphasis on the muscles in your back, specifically the spinal erectors.In contrast, the sumo deadlift focuses more on your leg muscles.",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Torso and shoulder position: When performing the sumo deadlift, pay close attention to your torso, maintaining a vertical angle and letting your legs do the work. Additionally, your shoulders should be directly in line with the barbell during a sumo deadlift, rather than slightly in front of the barbell as with the conventional deadlift.",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                ]),
              ),
            )));
  }
}
