import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:fyp/core/widgets/drawer.dart';

//stateful for (const) performance optimization
class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          leading: IconButton(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
              icon: Image.asset(
                'images/menu.png',
                height: 20,
                color: Colors.black,
              ),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              }),
          backgroundColor: Colors.white,
          actions: const [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 25, 180, 0),
                child: Text(
                  'About',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "SanFranciscos",
                      fontSize: 20,
                      decorationColor: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      drawer: MainDrawer(),
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'Nischaya Shrestha',
        textColor: Colors.white,
        backgroundColor: Colors.black,
        email: 'Nischayashrstha09@gmail.com',
        // textFont: 'Sail',
      ),
      body: Container(
        child: ContactUs(
            cardColor: Colors.white,
            textColor: Colors.teal.shade900,
            logo: const AssetImage('images/mtb.png'),
            email: 'Nischayashrestha09@gmail.com',
            companyName: '',
            companyColor: Colors.white,
            dividerThickness: 2,
            phoneNumber: '9860121459',
            tagLine: 'Flutter Developer',
            taglineColor: Colors.teal.shade100,
            twitterHandle: 'Nischayashrestha09',
            instagram: 'Nischaya___',
            facebookHandle: 'Nischaya Shrestha'),
      ),
    );
  }
}
