import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final storage = new FlutterSecureStorage();

  String fname = '';
  String lname = '';
  String email = '';

  bool loading = true;

  String token = '';
  String refresh = '';

  Future gettoken() async {
    String? jwt = await storage.read(key: "token");
    String? refresh = await storage.read(key: "refresh");
    if (jwt != null) {
      setState(() {
        this.token = jwt;
        this.refresh = refresh!;
        loadProfile();
      });
    } else {
      token = "Gym";
    }
  }

  @override
  void initState() {
    super.initState();
    gettoken();
  }

  Future loadProfile() async {
    final profilejson = await http.get(
      Uri.parse('http://192.168.10.132:8000/api/user/profile/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (profilejson.statusCode == 200) {
      final decodeddata = jsonDecode(profilejson.body);
      setState(() {
        this.fname = decodeddata["first_name"];
        this.email = decodeddata["email"];
        this.lname = decodeddata["last_name"];
        this.loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: (loading == false)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      CupertinoIcons.person_alt_circle,
                      color: Colors.black,
                      size: 150,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(fname + " " + lname, style: TextStyle(fontSize: 18)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(email, style: TextStyle(fontSize: 16))
                  ],
                )
              : Center(
                  child: SingleChildScrollView(),
                ),
        ),
      ),
    );
  }
}
