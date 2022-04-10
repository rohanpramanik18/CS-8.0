import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_pro/Projects/finishedProjects.dart';

class CurrentProjects extends StatefulWidget {
  @override
  State<CurrentProjects> createState() => _CurrentProjectsState();
}

class _CurrentProjectsState extends State<CurrentProjects> {
  //List<LatLng> tappedPoints = [];
  late List<DocumentSnapshot> eventsData;
  int _lengthOfEventsData = 0;

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Projects');

  List data = [];
  late int length;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('/Projects')
        .where('status', isEqualTo: "ongoing")
        .get()
        .then((docs) {
      setState(() {
        eventsData = docs.docs;
        _lengthOfEventsData = docs.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView.builder(
        itemCount: _lengthOfEventsData,
        itemBuilder: (BuildContext context, int index) {
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
                          eventsData[index]['pname'],
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
                        eventsData[index]['pdesc'],
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text(
                        eventsData[index]['address'],
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              myTransaction
                                  .update(eventsData[index].reference, {
                                'status': "finished",
                              });
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FinishedProjects()));
                          },
                          child: Text("Mark Finished")),
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
}
