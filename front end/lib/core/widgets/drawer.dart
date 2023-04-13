import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fyp/feature/login/views/login.dart';
import 'package:fyp/feature/notifications/views/notification_screen.dart';
import 'package:fyp/feature/profile_screen.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
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

  Future deletetoken() async {
    await storage.delete(key: "token");
    await storage.delete(key: "refresh");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Drawer(
            child: Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 20, 0),
      child: Column(children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          title: Text('Home',
              style: TextStyle(
                fontSize: 20,
              )),
          hoverColor: Color.fromRGBO(194, 236, 255, 1),
          leading: Image.asset(
            'images/home.png',
            color: Color.fromRGBO(53, 6, 102, 1),
            height: 30,
          ),
          onTap: () {},
        ),
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          title: Text('Notification',
              style: TextStyle(
                fontSize: 20,
              )),
          hoverColor: Color.fromRGBO(194, 236, 255, 1),
          leading: Image.asset(
            'images/notification.png',
            color: Color.fromRGBO(53, 6, 102, 1),
            height: 30,
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationScreen()));
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          title: Text(
            'Profile',
            style: TextStyle(fontSize: 20),
          ),
          hoverColor: Color.fromRGBO(194, 236, 255, 1),
          leading: Image.asset(
            'images/user.png',
            color: Color.fromRGBO(53, 6, 102, 1),
            height: 30,
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          title: Text(
            'About us',
            style: TextStyle(fontSize: 20),
          ),
          hoverColor: Color.fromRGBO(194, 236, 255, 1),
          leading: Image.asset(
            'images/information-button.png',
            color: Color.fromRGBO(53, 6, 102, 1),
            height: 30,
          ),
          onTap: () {},
        ),
        Spacer(),
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          title: Text(
            'log Out',
            style: TextStyle(fontSize: 20),
          ),
          hoverColor: Color.fromRGBO(194, 236, 255, 1),
          leading: Image.asset(
            'images/logout.png',
            color: Color.fromRGBO(53, 6, 102, 1),
            height: 30,
          ),
          onTap: () {
            deletetoken();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Mylogin()));
          },
        ),
        SizedBox(
          height: 20,
        )
      ]),
    )));
  }
}

// class DrawerList extends StatelessWidget {
//   const DrawerList({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
//       title: Text(
//         'Home',
//         style: TextStyle(
//           fontSize: 20,
//         ),
//       ),
//       hoverColor: Color.fromRGBO(194, 236, 255, 1),
//       leading: Image.asset(
//         'images/home.png',
//         color: Color.fromRGBO(53, 6, 102, 1),
//         height: 30,
//       ),
//       onTap: () {},
//     );
//   }
// }
