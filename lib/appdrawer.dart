import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_pro/pages/cardmaker.dart';
import 'package:learn_pro/pages/contacts.dart';
import 'package:learn_pro/pages/login_signup/login.dart';
import 'package:learn_pro/pages/my_cards.dart';
import 'package:learn_pro/pages/settings/account_settings.dart';
import 'package:learn_pro/pages/settings/settings.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final user = FirebaseAuth.instance.currentUser;
  late File? image;
  late String? userfullname;
  late String? useremail;

  void initState() {
    super.initState();
    image = AccountSettings.userImage;
    userfullname = AccountSettings.userfullname;
    useremail = AccountSettings.useremail;
  }

  logoutDialogue() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 130.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "You sure want to logout?",
                  style: TextStyle(
                    fontFamily: 'Signika Negative',
                    fontSize: 21.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 3.5),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 3.5),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
                accountName: Text(
                  user!.displayName.toString(),
                  textScaleFactor: 1.25,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                accountEmail: Text(
                  user!.email.toString(),
                  textScaleFactor: 1.1,
                ),
                currentAccountPicture: (image == null)
                    ? ClipOval(
                        child: Image.network(user!.photoURL.toString()),
                      )
                    : ClipOval(
                        child: Image.file(
                          image!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      )),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 10),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(
                    Icons.logout_outlined,
                    color: Color(0xFF33ADFF),
                  ),
                ),
                GestureDetector(
                  onTap: () => logoutDialogue(),
                  child: Text(
                    "Sign out",
                    style: TextStyle(color: Colors.black),
                    textScaleFactor: 1.15,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
