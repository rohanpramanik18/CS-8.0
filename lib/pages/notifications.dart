import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  int notification = 2;

  final notificationList = [
    {
      'title': 'Biggest Offers on New Courses!',
      'description':
          'Top New Courses at Lowest Prices. Avail 10% Instant Discount* on HDFC Cards. Only till July 25th!'
    },
    {
      'title': 'Biggest Sale Of The Year!',
      'description':
          'Biggest Sale of the year started now only on Learn Pro. Browse courses and start learning now. Hurry!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('My Notifications'),
        titleSpacing: 0.0,
      ),
      backgroundColor: const Color(0xFFF1F3F6),
      body: (notification == 0)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.bellSlash,
                    color: Colors.grey,
                    size: 60.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'No Notifications',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                final item = notificationList[index];
                return Dismissible(
                  key: Key('$item'),
                  onDismissed: (direction) {
                    setState(() {
                      notificationList.removeAt(index);
                      notification--;
                    });

                    // Then show a snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${item['title']} dismissed")));
                  },
                  // Show a red background as the item is swiped away.
                  background: Container(color: Colors.red),
                  child: Container(
                    child: Card(
                      elevation: 2.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              child: Icon(
                                FontAwesomeIcons.bell,
                                size: 30.0,
                              ),
                              radius: 40.0,
                            ),
                          ),
                          Container(
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${item['title']}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0,
                                      right: 8.0,
                                      left: 8.0,
                                      bottom: 8.0),
                                  child: Text(
                                    '${item['description']}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      height: 1.6,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
