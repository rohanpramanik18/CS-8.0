import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_pro/addWorker/addWorkerData.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/appdrawer.dart';
import 'package:learn_pro/pages/myTeam.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    nestedAppBar() {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 180,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/appbar_bg2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    'My Workers',
                    textScaleFactor: 2.0,
                    style: TextStyle(
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ];
        },
        body: Container(
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddWorkerData())),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 3, color: Colors.blue)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.message,
                        color: Color(0xFF33ADFF),
                        size: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "Add Workers",
                        style: TextStyle(color: Colors.black),
                        textScaleFactor: 1.15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => myTeam())),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 3, color: Colors.blue)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.message,
                        color: Color(0xFF33ADFF),
                        size: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "My Team",
                        style: TextStyle(color: Colors.black),
                        textScaleFactor: 1.15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      );
    }

    return Scaffold(
      body: nestedAppBar(),
    );
  }
}
