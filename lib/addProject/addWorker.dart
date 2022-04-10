import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_pro/Projects/currentProjects.dart';
import 'package:learn_pro/addProject/projectSummary.dart';

class AddWorker extends StatefulWidget {
  @override
  State<AddWorker> createState() => _AddWorkerState();
}

class _AddWorkerState extends State<AddWorker> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Workers"),
      ),
      body: Column(children: [
        /*ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile();
          },
        ),*/
        /*ElevatedButton(
          child: Text("Create Project"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (ProjectSummary())));
          },
        ),*/
      ]),
    );
  }
}
