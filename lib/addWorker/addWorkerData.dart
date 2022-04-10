import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_pro/addWorker/workerDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_pro/pages/home/home.dart';
import 'package:learn_pro/pages/home/home_main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:learn_pro/addWorker/storage_service.dart';

import '../pages/settings/account_settings.dart';

late FirebaseAuth _auth;

class AddWorkerData extends StatefulWidget {
  static late File? userImage;
  static late File? userAadhar;
  @override
  State<AddWorkerData> createState() => _AddWorkerDataState();
}

class _AddWorkerDataState extends State<AddWorkerData> {
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
  String download_url = "None";
  String download_url2 = "None";

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
        AddWorkerData.userImage = this.userimage;
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
        AddWorkerData.userImage = this.userAadhar;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Worker Details"),
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
                      Text(
                        'Add your worker details',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Signika Negative',
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Worker ID',
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
                                  controller: wid,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Signika Negative',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Worker id',
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
                                'Gender',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                  width: width - 50,
                                  height: 60,
                                  child: DropdownButton<String>(
                                    value: workerGender,
                                    items: <String>['Male', 'Female', 'Others']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      workerGender = newValue;
                                    },
                                  )),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Aadhar Number',
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
                                  controller: waadhar,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Signika Negative',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter aadhar number',
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
                                'Upload Aadhar File',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    final results =
                                        await FilePicker.platform.pickFiles(
                                      allowMultiple: true,
                                    ); //Add multiple files and filetype filters in future

                                    if (results == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("File not selected"),
                                        ),
                                      );
                                      return null;
                                    }

                                    String? path = results.files.single.path;
                                    String fileName = results.files.single.name;

                                    storage.uploadFile(path!, fileName).then(
                                        (value) => ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text("Adhaar Uploaded"),
                                            )));

                                    /*storage
                            .downloadUrl(fileName)
                            .then((value) => download_url = value);*/

                                    download_url = fileName;
                                  },
                                  child: Text("Upload Adhaar")),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      //Aadhar upload

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Upload Worker Image',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    final results =
                                        await FilePicker.platform.pickFiles(
                                      allowMultiple: true,
                                    ); //Add multiple files and filetype filters in future

                                    if (results == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("File not selected"),
                                        ),
                                      );
                                      return null;
                                    }

                                    String? path = results.files.single.path;
                                    String fileName = results.files.single.name;

                                    storage.uploadFile(path!, fileName).then(
                                        (value) => ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Profile Image Uploaded"),
                                            )));

                                    /*storage
                            .downloadUrl(fileName)
                            .then((value) => download_url = value);*/

                                    download_url2 = fileName;
                                  },
                                  child: Text("Upload Profile Photo")),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            //print(workerGender);
                            //print(wid.text);
                            //print(workerGender);
                            WorkerDetils.workerId = wid.text;
                            WorkerDetils.workerName = wname.text;
                            WorkerDetils.workerAge = wage.text;
                            WorkerDetils.workerGender = workerGender;
                            WorkerDetils.workerPhone = wphone.text;
                            WorkerDetils.workerAadhar = waadhar.text;

                            var x = {
                              'WID': WorkerDetils.workerId = wid.text,
                              'Name': WorkerDetils.workerName = wname.text,
                              'Gender': WorkerDetils.workerGender =
                                  workerGender,
                              'Age': WorkerDetils.workerAge = wage.text,
                              'Phone': WorkerDetils.workerPhone = wphone.text,
                              'Aadhar': WorkerDetils.workerAadhar =
                                  waadhar.text,
                              'AadharImage': download_url,
                              'ProfileImg': download_url2,
                            };

                            await collectionReference.add(x).catchError((err) {
                              print("Error $err");
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
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
                              'Save Worker',
                              style: TextStyle(
                                fontFamily: 'Signika Negative',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
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
