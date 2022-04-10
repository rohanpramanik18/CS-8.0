import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn_pro/pages/home/home_main.dart';
import 'package:learn_pro/pages/my_cards.dart';
import 'package:learn_pro/pages/search.dart';
import 'package:learn_pro/pages/settings/settings.dart';
import 'package:learn_pro/pages/contacts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? currentIndex;
  DateTime? currentBackPressTime;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        onItemSelected: (index) => changePage(index),
        showElevation: true,
        selectedIndex: currentIndex!,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(
              Icons.home,
            ),
            activeColor: Color(0xFF33ADFF),
            textAlign: TextAlign.center,
            title: Text(
              'Home',
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.person,
            ),
            activeColor: Color(0xFF33ADFF),
            textAlign: TextAlign.center,
            title: Text(
              'My Workers',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.settings,
            ),
            activeColor: Color(0xFF33ADFF),
            textAlign: TextAlign.center,
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 17.0),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        child: (currentIndex == 0)
            ? HomeMain()
            : (currentIndex == 1)
                ? Contacts()
                : Settings(),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    } else {
      return true;
    }
  }
}
