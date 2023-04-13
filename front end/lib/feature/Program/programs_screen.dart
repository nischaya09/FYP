import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fyp/core/widgets/drawer.dart';
import 'package:fyp/feature/Program/subprogarms_screen.dart';
import 'package:fyp/modals/programs.dart';
import 'package:fyp/widgets/listwidget.dart';
import 'package:http/http.dart' as http;

class Programs extends StatefulWidget {
  @override
  _ProgramsState createState() => _ProgramsState();
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

class _ProgramsState extends State<Programs> {
  late Future<List<ProgramsModel>> futurePrograms;
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
      futurePrograms = fetchPrograms();
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

  Future<List<ProgramsModel>> fetchPrograms() async {
    final response = await http.get(
      Uri.parse("http://192.168.10.132:8000/api/programs/all/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ProgramsModel.fromJson(data)).toList();
    } else {
      throw Exception('Unable to get programs list');
    }
  }

  @override
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _light ? _lightTheme : _darkTheme,
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
          title: Text(
            'Programs',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "SanFranciscos",
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            Switch(
                value: _light,
                onChanged: (state) {
                  setState(() {
                    _light = state;
                  });
                })
          ],
        ),
        drawer: MainDrawer(),
        body: Scaffold(
          body: FutureBuilder<List<ProgramsModel>>(
            future: fetchPrograms(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProgramsModel> data = snapshot.data!;

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubProgramsPage(
                                      id: data[index].id,
                                      name: data[index].name)));
                        },
                        child: ProgramWidgets(
                            title: data[index].name, img: data[index].image),
                      );
                    });
              } else {
                Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
