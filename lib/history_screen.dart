import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/simple_line_icons.dart';
import 'package:intl/intl.dart';

import 'database.dart';
import 'themes/helpers/theme_colors.dart';

List<Icon> listIcon = [
  Icon(
    Icons.remove,
    color: Colors.white,
  ),
  Icon(
    Icons.add,
    color: Colors.white,
  ),
];
List<Color> listColor = [
  removeColor,
  confirmColor,
];

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Select Date:'),
              IconButton(
                icon: Icon(SimpleLineIcons.getIconData('calendar')),
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2019, 1, 1),
                    onConfirm: (date) {
                      print('confirm $date');
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Database().getStreamCollection(
                collection: 'product_history',
                orderBy: 'date',
                isDescending: true,
              ),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return HistoryCardView(
                          productName: document['productName'],
                          productCategory: document['productCategory'],
                          employeeLastName: document['employeeLastName'],
                          employeeFirstName: document['employeeFirstName'],
                          action: document['action'],
                          date: document['date'],
                        );
                      }).toList(),
                    );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class HistoryCardView extends StatelessWidget {
  const HistoryCardView({
    Key key,
    @required this.productName,
    @required this.productCategory,
    @required this.employeeFirstName,
    @required this.employeeLastName,
    @required this.action,
    @required this.date,
  }) : super(key: key);

  final String action;
  final Timestamp date;
  final String employeeFirstName;
  final String employeeLastName;
  final String productCategory;
  final String productName;

  bool equalsIgnoreCase(String a, String b) {
    return (a == null && b == null) ||
        (a != null && b != null && a.toLowerCase() == b.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              productName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              minFontSize: 20.0,
                              maxFontSize: 256.0,
                            ),
                            AutoSizeText(
                              productCategory,
                              style: TextStyle(color: Colors.grey),
                              minFontSize: 8.0,
                              maxFontSize: 256.0,
                            ),
                            Divider(
                              color: cancelColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    AutoSizeText(
                                      'Date',
                                      minFontSize: 8.0,
                                      maxFontSize: 128.0,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: AutoSizeText(
                                        DateFormat('yMMMMd')
                                            .format(date.toDate()),
                                        minFontSize: 8.0,
                                        maxFontSize: 128.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    AutoSizeText(
                                      'By',
                                      minFontSize: 8.0,
                                      maxFontSize: 128.0,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: AutoSizeText(
                                            employeeLastName +
                                                employeeFirstName,
                                            style: TextStyle(),
                                            minFontSize: 8.0,
                                            maxFontSize: 128.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    AutoSizeText(
                                      'Action',
                                      minFontSize: 8.0,
                                      maxFontSize: 128.0,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: AutoSizeText(
                                        action,
                                        style: TextStyle(),
                                        minFontSize: 8.0,
                                        maxFontSize: 128.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              height: 35.0,
              width: 35.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(128.0),
                  ),
                ),
                color: equalsIgnoreCase(action, 'added')
                    ? listColor.elementAt(1)
                    : listColor.elementAt(0),
                elevation: 6.0,
                child: equalsIgnoreCase(action, 'added')
                    ? listIcon.elementAt(1)
                    : listIcon.elementAt(0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
