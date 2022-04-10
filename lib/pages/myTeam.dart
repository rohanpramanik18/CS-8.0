import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_pro/addWorker/editWorker.dart';
import 'package:learn_pro/pages/home/home.dart';
import 'package:learn_pro/pages/home/home_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:learn_pro/addWorker/storage_service.dart';

class myTeam extends StatefulWidget {
  @override
  _myTeam createState() => _myTeam();
}

class _myTeam extends State<myTeam> {
  late List<DocumentSnapshot> eventsData;
  int _lengthOfEventsData = 0;

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('WorkerData');

  List data = [];
  late int length;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('/WorkerData').get().then((docs) {
      setState(() {
        eventsData = docs.docs;
        _lengthOfEventsData = docs.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Storage storage = Storage();
    String netURLDef =
        "https://demofree.sirv.com/nope-not-here.jpg"; //By default
    return Scaffold(
      appBar: AppBar(title: Text("My Team"), actions: <Widget>[
        MaterialButton(
          color: Colors.white,
          child: Text(
            "Continue",
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
      ]),
      body: ListView.builder(
        itemCount: _lengthOfEventsData,
        itemBuilder: (BuildContext context, int index) {
          print(eventsData[index].reference);
          return Container(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
            child: Center(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text(
                          eventsData[index]['WID'],
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text(
                        eventsData[index]['Name'],
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text(
                        eventsData[index]['Gender'],
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text(
                        eventsData[index]['Age'],
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text(
                        eventsData[index]['Phone'],
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text(
                        eventsData[index]['Aadhar'],
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              myTransaction.delete(eventsData[index].reference);
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => myTeam()));
                          },
                          child: Text("Remove from team")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => EditWorkerData(
                                        eventsData[index].reference))));
                          },
                          child: Text("Edit details")),
                      ElevatedButton(
                          onPressed: () {
                            String fileNameUploaded =
                                eventsData[index]['AadharImage'].toString();
                            storage.downloadUrl(fileNameUploaded).then((value) {
                              print(value);
                              netURLDef = value;
                              _launchURL(netURLDef);
                            });
                          },
                          child: Text("Check Aadhar")),
                      ElevatedButton(
                          onPressed: () {
                            String fileNameUploaded =
                                eventsData[index]['ProfileImg'].toString();
                            storage.downloadUrl(fileNameUploaded).then((value) {
                              print(value);
                              netURLDef = value;
                              _launchURL(netURLDef);
                            });
                          },
                          child: Text("Check Profile")),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await launch(url);
    }
  }
}
