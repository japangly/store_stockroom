import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/octicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recase/recase.dart';

import 'database.dart';
import 'product_details.dart';

class GridCardView extends StatefulWidget {
  final String selectedSortBy;
  final bool selectedShownBy;
  const GridCardView({
    Key key,
    @required this.selectedSortBy,
    @required this.selectedShownBy,
  }) : super(key: key);

  @override
  _GridCardViewState createState() => _GridCardViewState();
}

class _GridCardViewState extends State<GridCardView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: Database().getStreamCollection(
          collection: 'products',
          orderBy: widget.selectedSortBy,
          isDescending: widget.selectedShownBy,
        ),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot document = snapshot.data.documents[index];
                  return Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      child: Image.network(
                                        document['image'],
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    children: <Widget>[
                                      Flexible(
                                        child: AutoSizeText(
                                          ReCase(document['name']).titleCase,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 8.0,
                                          maxFontSize: 128.0,
                                        ),
                                      ),
                                      Flexible(
                                        child: AutoSizeText(
                                          document['category'].toString().toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          minFontSize: 8.0,
                                          maxFontSize: 128.0,
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Octicons.getIconData(
                                                        'primitive-dot',
                                                      ),
                                                      color: Colors.orange[500],
                                                    ),
                                                    AutoSizeText(
                                                      'In Use',
                                                      style: TextStyle(
                                                        color:
                                                            Colors.orange[500],
                                                      ),
                                                      minFontSize: 8.0,
                                                      maxFontSize: 128.0,
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0),
                                                  child: AutoSizeText(
                                                    document['inUse']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Colors.orange[500],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    minFontSize: 8.0,
                                                    maxFontSize: 128.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Octicons.getIconData(
                                                        'primitive-dot',
                                                      ),
                                                      color: Colors.green[500],
                                                    ),
                                                    AutoSizeText(
                                                      'In Stock',
                                                      style: TextStyle(
                                                        color:
                                                            Colors.green[500],
                                                      ),
                                                      minFontSize: 8.0,
                                                      maxFontSize: 128.0,
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0),
                                                  child: AutoSizeText(
                                                    document['inStock']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Colors.green[500],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    minFontSize: 8.0,
                                                    maxFontSize: 128.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  child: ProductDetails(
                                    document: document,
                                  ),
                                  type: PageTransitionType.rightToLeftWithFade),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
