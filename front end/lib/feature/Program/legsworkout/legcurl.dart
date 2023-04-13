import 'package:flutter/material.dart';
import 'package:fyp/core/widgets/drawer.dart';

class LegCurl extends StatelessWidget {
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
                              image: AssetImage('images/legcurl.gif'),
                              fit: BoxFit.fill))),
                  Container(
                    child: Text("How to perform leg curl?",
                        style: TextStyle(
                          fontFamily: "SanFranciscos",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Stand with your feet hip-width apart. Place your hands on your waist or on a chair for balance. ",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Slowly bend your right knee, bringing your heel toward your butt. Keep your thighs parallel..",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 0, top: 10, right: 170),
                      child: Text("Slowly lower your foot.. ",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 0, top: 10, right: 170),
                      child: Text("Complete 12 to 15 reps.",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                ]),
              ),
            )));
  }
}
