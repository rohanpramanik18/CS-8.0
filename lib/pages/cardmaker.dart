import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_pro/pages/settings/account_settings.dart';

class CardMaker extends StatefulWidget {
  static late File? profilepic = null;
  @override
  State<CardMaker> createState() => _CardMakerState();
}

class _CardMakerState extends State<CardMaker> {
  var namecontroller = TextEditingController();

  var phonecontroller = TextEditingController();

  var emailcontroller = TextEditingController();

  var titlecontroller = TextEditingController();

  var companycontroller = TextEditingController();

  var addresscontroller = TextEditingController();

  late File? image;

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
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text("Import from account"),
                  onTap: () {
                    CardMaker.profilepic = AccountSettings.userImage;
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
        this.image = imageTemp;
        CardMaker.profilepic = this.image;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Card Details",
          textScaleFactor: 1.2,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
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
                      'Add your card details',
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
                                controller: namecontroller,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Signika Negative',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter Full Name',
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
                                keyboardType: TextInputType.phone,
                                controller: phonecontroller,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Signika Negative',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter Phone number',
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
                              'Email',
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
                                controller: emailcontroller,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Signika Negative',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter Email address',
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
                              'Title',
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
                                controller: titlecontroller,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Signika Negative',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter your bussiness title',
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
                              'Company',
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
                                controller: emailcontroller,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Signika Negative',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter Company name',
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
                              'Address',
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
                                controller: addresscontroller,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Signika Negative',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter your address',
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
                              'Profile picture',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Signika Negative',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            (CardMaker.profilepic == null)
                                ? ElevatedButton(
                                    style: ButtonStyle(),
                                    onPressed: () {
                                      showImageSource(context);
                                    },
                                    child: Text("Select image"))
                                : Container(
                                    child: Image.file(
                                      image!,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
                            'Create Card',
                            style: TextStyle(
                              fontFamily: 'Signika Negative',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
