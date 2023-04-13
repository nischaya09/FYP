import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fyp/core/widgets/drawer.dart';
import 'package:http/http.dart' as http;

class GymProduct1 extends StatefulWidget {
  final int id;
  const GymProduct1({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<GymProduct1> createState() => _GymProduct1State();
}

class _GymProduct1State extends State<GymProduct1> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';
  String subtitle = '';
  int price = 0;
  String descp = '';
  String image = '';

  bool loading = true;

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
      loaddetail();
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

  Future loaddetail() async {
    final detailjson = await http.get(
      Uri.parse('http://192.168.10.132:8000/api/product/${widget.id}/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (detailjson.statusCode == 200) {
      final decodeddata = jsonDecode(detailjson.body);
      print(decodeddata);
      setState(() {
        name = decodeddata["name"];
        subtitle = decodeddata["subtitle"];
        price = decodeddata["price"];
        image = decodeddata["image"];
        descp = decodeddata["description"];
        loading = false;
      });
    }
  }

  getproduct() async {
    final response = await http.post(
      Uri.parse("http://192.168.10.82:8000/api/product/${widget.id}/buy/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 201) {
      setState(() {
        loading = false;
      });
      message(context, "Purchase Notification Send Sucessfully");
    } else {
      setState(() {
        loading = false;
      });
      throw message(context, "Failed : Unable to buy product");
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

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: scaffoldKey,
            extendBodyBehindAppBar: true,
            drawer: MainDrawer(),
            body: (loading == false)
                ? SingleChildScrollView(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(children: [
                          Container(
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(40.0),
                                  bottomRight: const Radius.circular(40.0),
                                ),
                                color: Color.fromRGBO(199, 139, 95, 1),
                              ),
                              padding: EdgeInsets.only(top: 100, left: 30),
                              child: Column(children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Column(children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                subtitle,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  right: 20, top: 5),
                                              child: Text(
                                                name,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ]),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 50,
                                          ),
                                          child: Image.network(
                                            image,
                                            height: 100,
                                          ),
                                        )
                                      ]),
                                      Row(
                                        children: [
                                          Column(children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 30),
                                                child: Text(
                                                  'Price',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5, bottom: 20),
                                                child: Text(
                                                  price.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ]),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ])),
                          Container(
                            margin:
                                const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Text(
                              descp,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 130, top: 25),
                              child: ElevatedButton(child: Text("Get"),
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(),
                               ),),
                               onPressed: () {
                                 setState(() {
                                   loading = true;
                                 });
                                 getproduct();
                               },
                                ),
                              // child: RaisedButton(
                              //   color: Colors.black,
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(18.0),
                              //     side: const BorderSide(),
                              //   ),
                              //   onPressed: () {
                              //     setState(() {
                              //       loading = true;
                              //     });
                              //     getproduct();
                              //   },
                              //   padding: const EdgeInsets.all(10.0),
                              //   textColor: Colors.white,
                              //   child: const Text("Get",
                              //       style: TextStyle(fontSize: 15)),
                              // )
                              )
                        ])))
                : Center(child: CircularProgressIndicator())));
  }
}
