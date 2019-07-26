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
  const GridCardView({
    Key key,
    @required this.selectedSortBy,
    @required this.selectedShownBy,
  }) : super(key: key);

  final bool selectedShownBy;
  final String selectedSortBy;

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
                  childAspectRatio: 0.62,
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
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      document['image'],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Column(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 2,
                                        child: AutoSizeText(
                                          ReCase(document.data['name'])
                                              .titleCase,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 20.0,
                                          maxFontSize: 128.0,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: AutoSizeText(
                                          document['category']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          minFontSize: 8.0,
                                          maxFontSize: 128.0,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Divider(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                              ),
                            ],
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
