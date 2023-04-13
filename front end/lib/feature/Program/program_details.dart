import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fyp/core/widgets/drawer.dart';

class ProgramDetailPage extends StatefulWidget {
  final int id;
  final String name;
  const ProgramDetailPage({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<ProgramDetailPage> createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends State<ProgramDetailPage> {
  String img = '';
  String title = '';
  String desc = '';
  bool loading = true;
  final storage = FlutterSecureStorage();

  String token = '';
  String refresh = '';

  Future gettoken() async {
    String? jwt = await storage.read(key: "token");
    String? refresh = await storage.read(key: "refresh");
    if (jwt != null) {
      setState(() {
        token = jwt;
        this.refresh = refresh!;
        programDetail();
      });
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

  Future programDetail() async {
    final response = await http.get(
      Uri.parse("http://192.168.10.132:8000/api/programs/sub/${widget.id}/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      print(decode["image"]);
      setState(() {
        this.title = decode["title"];
        this.img = decode["image"];
        this.desc = decode["desc"];
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return MaterialApp(
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
                widget.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "SanFranciscos",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            drawer: MainDrawer(),
            body: loading == false
                ? SingleChildScrollView(
                    child: Column(children: [
                    Container(
                      width: double.infinity,
                      child: Image.network(
                        img,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        desc,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ]))
                : Center(child: CircularProgressIndicator())));
  }
}
