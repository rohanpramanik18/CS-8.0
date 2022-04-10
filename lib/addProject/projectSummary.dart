import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_pro/Projects/projectsHome.dart';
import 'package:learn_pro/addProject/projectDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late FirebaseAuth _auth;

class ProjectSummary extends StatefulWidget {
  @override
  State<ProjectSummary> createState() => _ProjectSummary();
}

class _ProjectSummary extends State<ProjectSummary> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Projects');

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Project"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  ProjectDetails.projectName,
                  textScaleFactor: 1.4,
                ),
                leading: Text(
                  "Project name : ",
                  textScaleFactor: 1.4,
                ),
              ),
              ListTile(
                title: Text(ProjectDetails.description),
                leading: Text("Project description : "),
              ),
              ListTile(
                title: Text(ProjectDetails.address),
                leading: Text("Project address : "),
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    pushData();
                  },
                  child: Text("Save Project"))
            ],
          ),
        ),
      ),
    );
  }

  void _showSubmitDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Project Successfully added"),
          content: new Text("Project added to current list!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Continue"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProjectHome()));
              },
            ),
          ],
        );
      },
    );
  }

  void pushData() async {
    if (true) {
      var x = {
        'pname': ProjectDetails.projectName,
        'pdesc': ProjectDetails.description,
        'address': ProjectDetails.address,
        'status': "ongoing",
        //'workers': ProjectDetails.workers,
      };
      await collectionReference.add(x).catchError((err) {
        print("Error $err");
      });
      _showSubmitDialog();
    }
  }
}
