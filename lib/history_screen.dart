import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/simple_line_icons.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

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
  DateTime _endDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 1,
  );

  DateTime _startDate = DateTime.utc(
    DateTime.fromMicrosecondsSinceEpoch(0).year,
    DateTime.fromMicrosecondsSinceEpoch(0).month,
    DateTime.fromMicrosecondsSinceEpoch(0).day,
  );

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
              Text(ReCase('select date:').titleCase),
              IconButton(
                icon: Icon(SimpleLineIcons.getIconData('calendar')),
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2019, 1, 1),
                    onConfirm: (date) {
                      setState(() {
                        _startDate = DateTime.utc(
                          date.year,
                          date.month,
                          date.day,
                        );
                        _endDate = DateTime.utc(
                          date.year,
                          date.month,
                          date.day + 1,
                        );
                      });
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
              stream: Firestore.instance
                  .collection('product_history')
                  .orderBy('date', descending: true)
                  .where('date', isGreaterThanOrEqualTo: _startDate)
                  .where('date', isLessThanOrEqualTo: _endDate)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return snapshot.data.documents.length == 0
                        ? Center(
                            child:
                                Text(ReCase('no recent history.').sentenceCase),
                          )
                        : ListView(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return HistoryCardView(
                                productName: document['product name'],
                                productCategory: document['product category'],
                                action: document['action'],
                                date: document['date'],
                                quantity: document['quantity'],
                                uid: document['uid'],
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
    @required this.action,
    @required this.date,
    @required this.quantity,
    @required this.uid,
  }) : super(key: key);

  final String action;
  final Timestamp date;
  final String productCategory;
  final String productName;
  final int quantity;
  final String uid;

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AutoSizeText(
                              ReCase(productName).titleCase,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              minFontSize: 20.0,
                              maxFontSize: 256.0,
                            ),
                            AutoSizeText(
                              ReCase(productCategory).sentenceCase,
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
                                      ReCase('date').titleCase,
                                      minFontSize: 8.0,
                                      maxFontSize: 128.0,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: AutoSizeText(
                                        DateFormat('d MMMM y')
                                            .format(date.toDate())
                                            .toString(),
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
                                        StreamBuilder<QuerySnapshot>(
                                            stream: Firestore.instance
                                                .collection('employees')
                                                .where('uid', isEqualTo: uid)
                                                .limit(1)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError)
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              switch (
                                                  snapshot.connectionState) {
                                                case ConnectionState.waiting:
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                default:
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: AutoSizeText(
                                                      ReCase(snapshot
                                                                      .data
                                                                      .documents
                                                                      .first[
                                                                  'first_name'] +
                                                              ' ' +
                                                              snapshot
                                                                      .data
                                                                      .documents
                                                                      .first[
                                                                  'last_name'])
                                                          .titleCase,
                                                      style: TextStyle(),
                                                      minFontSize: 8.0,
                                                      maxFontSize: 128.0,
                                                    ),
                                                  );
                                              }
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    AutoSizeText(
                                      ReCase('action').titleCase,
                                      minFontSize: 8.0,
                                      maxFontSize: 128.0,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: AutoSizeText(
                                        action.toUpperCase(),
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
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                quantity.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                                minFontSize: 20.0,
                                maxFontSize: 256.0,
                              ),
                            ],
                          ),
                        ),
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
                color: (equalsIgnoreCase(action, 'created') ||
                        equalsIgnoreCase(action, 'added'))
                    ? listColor.elementAt(1)
                    : listColor.elementAt(0),
                elevation: 6.0,
                child: (equalsIgnoreCase(action, 'created') ||
                        equalsIgnoreCase(action, 'added'))
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
