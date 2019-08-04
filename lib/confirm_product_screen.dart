import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

import 'database.dart';
import 'themes/helpers/theme_colors.dart';

class ConfirmProductScreen extends StatefulWidget {
  @override
  _ConfirmProductScreenState createState() => _ConfirmProductScreenState();
}

class _ConfirmProductScreenState extends State<ConfirmProductScreen> {
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('product_history')
                  .where('is_pending', isEqualTo: true)
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
                                productDocID: document.documentID,
                                productName: document['name'],
                                productCategory: document['category'],
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
    @required this.productDocID,
    @required this.productName,
    @required this.productCategory,
    @required this.action,
    @required this.date,
    @required this.quantity,
    @required this.uid,
  }) : super(key: key);

  final String productDocID;
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
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
                                StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection('employees')
                                        .where('uid', isEqualTo: uid)
                                        .limit(1)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError)
                                        return Text('Error: ${snapshot.error}');
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        default:
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: AutoSizeText(
                                              ReCase(snapshot.data.documents
                                                          .first['first_name'] +
                                                      ' ' +
                                                      snapshot.data.documents
                                                          .first['last_name'])
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
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: removeColor,
                                  ),
                                  onPressed: () async {
                                    await Database().updateCollection(
                                      collection: 'product_history',
                                      documentId: productDocID,
                                      data: {
                                        'is_pending': false,
                                        'date': Timestamp.now(),
                                        'date_request': date,
                                        'action': 'reject'
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.check_circle_outline,
                                    color: confirmColor,
                                  ),
                                  onPressed: () async {
                                    await Database().updateCollection(
                                      collection: 'product_history',
                                      documentId: productDocID,
                                      data: {
                                        'is_pending': false,
                                        'date': Timestamp.now(),
                                        'date_request': date
                                      },
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
