import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_pro/addProject/addMap.dart';
import 'package:learn_pro/addProject/projectDetails.dart';

class CreateProject extends StatefulWidget {
  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  var pname = TextEditingController();
  var pdesc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create project"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Project Name',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Signika Negative',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      // width: width - 50,
                      height: 60,
                      child: TextField(
                        controller: pname,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Signika Negative',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Project Name',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Signika Negative',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Project Description',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Signika Negative',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      // width: width - 50,
                      height: 60,
                      child: TextField(
                        controller: pdesc,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Signika Negative',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Project description',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Signika Negative',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    ProjectDetails.projectName = pname.text;
                    ProjectDetails.description = pdesc.text;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddMap()));
                  },
                  child: Text("Next"))
            ],
          ),
        ));
  }
}
