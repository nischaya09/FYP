import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/modals/notifications.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModal>> notifications;
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
      var _timer =
          new Timer.periodic(const Duration(seconds: 2), callnotification);
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

  Future<List<NotificationModal>> displayNotification() async {
    final response = await http.get(
      Uri.parse("http://192.168.10.132:8000/api/notifications/all/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => NotificationModal.fromJson(data))
          .toList();
    } else {
      throw Exception("unable to load notifications");
    }
  }

  callnotification(Timer timer) {
    setState(() {
      notifications = displayNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: FutureBuilder<List<NotificationModal>>(
          future: displayNotification(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<NotificationModal> data = snapshot.data!;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          title: Text(data[index].title),
                          tileColor: Colors.grey[100]),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )
        //
        );
  }
}
