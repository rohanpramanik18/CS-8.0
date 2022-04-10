import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_pro/addWorker/workerDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_pro/pages/home/home.dart';
import 'package:learn_pro/pages/home/home_main.dart';
import 'package:learn_pro/pages/myTeam.dart';

import '../pages/settings/account_settings.dart';

late FirebaseAuth _auth;

class EditWorkerData extends StatefulWidget {
  static late DocumentReference indexid1;
  EditWorkerData(DocumentReference indexid) {
    indexid1 = indexid;
  }
  static late File? userImage;
  static late File? userAadhar;
  @override
  State<EditWorkerData> createState() => _EditWorkerDataState();
}

class _EditWorkerDataState extends State<EditWorkerData> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('WorkerData');

  var wid = TextEditingController();
  var wname = TextEditingController();
  var wage = TextEditingController();
  late var workerGender = null;
  var wphone = TextEditingController();
  var waadhar = TextEditingController();

  File? userimage;
  File? userAadhar;

  Future<ImageSource?> showImageSource(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text("Gallery"),
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                )
              ],
            ));
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      String imagePath = image.path;
      final imageTemp = File(imagePath);
      setState(() {
        this.userimage = imageTemp;
        EditWorkerData.userImage = this.userimage;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future<ImageSource?> showAadharSource(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                  onTap: () {
                    pickAadhar(ImageSource.camera);
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text("Gallery"),
                  onTap: () {
                    pickAadhar(ImageSource.gallery);
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                )
              ],
            ));
  }

  Future pickAadhar(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      String imagePath = image.path;
      final imageTemp = File(imagePath);
      setState(() {
        this.userAadhar = imageTemp;
        EditWorkerData.userImage = this.userAadhar;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Worker Details"),
      ),
      body: SingleChildScrollView(
        child: ListView(
          primary: false,
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width - 30.0,
                  margin: EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: width - 50,
                                height: 60,
                                child: TextField(
                                  controller: wname,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Signika Negative',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Worker Name',
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
                        ],
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Age',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: width - 50,
                                height: 60,
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  controller: wage,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Signika Negative',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter worker age',
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
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Phone',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: width - 50,
                                height: 60,
                                child: TextField(
                                  controller: wphone,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Signika Negative',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Enter worker\'s phone number ",
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
                        ],
                      ),
                      SizedBox(height: 12.0),
                      SizedBox(height: 12.0),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: InkWell(
                            onTap: () async {
                              WorkerDetils.workerName = wname.text;
                              WorkerDetils.workerAge = wage.text;
                              WorkerDetils.workerPhone = wphone.text;

                              var x = {
                                'Name': WorkerDetils.workerName = wname.text,
                                'Age': WorkerDetils.workerAge = wage.text,
                                'Phone': WorkerDetils.workerPhone = wphone.text,
                              };
                              await FirebaseFirestore.instance.runTransaction(
                                  (Transaction myTransaction) async {
                                myTransaction.update(EditWorkerData.indexid1, {
                                  'Name': WorkerDetils.workerName = wname.text,
                                  'Age': WorkerDetils.workerAge = wage.text,
                                  'Phone': WorkerDetils.workerPhone =
                                      wphone.text
                                });
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => myTeam()));
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF33ADFF),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Edit Data',
                                style: TextStyle(
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
