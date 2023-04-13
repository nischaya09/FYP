import 'package:flutter/material.dart';
import 'package:fyp/core/widgets/drawer.dart';

class Burpees extends StatelessWidget {
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
                      padding: const EdgeInsets.fromLTRB(0, 25, 160, 0),
                      child: Text(
                        'Burpeess',
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
                              image: AssetImage('images/burpees.gif'),
                              fit: BoxFit.fill))),
                  Container(
                    child: Text("How to perform Burpees?",
                        style: TextStyle(
                          fontFamily: "SanFranciscos",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Squat: From standing, squat and place hands on the floor in front of you, just outside of feet. ",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Plank: Jump both feet back so you’re in plank position.",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Push-up: Drop to a push-up — your chest should touch the floor. You can also place your knees on the floor here, which makes the push-up easier.",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          " Plank: Return to plank position. This can be a strict push-up, a push-up from the knees, or not a push-up at all. As in, just push yourself up from the floor as you would if you weren’t working out — your choice",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10, right: 80),
                      child: Text("Squat: Jump feet back in toward hands.",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                          "Jump: Explosively jump into the air, reaching arms straight overhead.",
                          style: TextStyle(
                            fontFamily: "SanFranciscos",
                            fontSize: 15,
                          ))),
                ]),
              ),
            )));
  }
}
