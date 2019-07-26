import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/octicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recase/recase.dart';

import 'database.dart';
import 'env.dart';
import 'product_details.dart';

class ListCardView extends StatefulWidget {
  final String selectedSortBy;
  final bool selectedShownBy;
  const ListCardView({
    Key key,
    @required this.selectedSortBy,
    @required this.selectedShownBy,
  }) : super(key: key);

  @override
  _ListCardViewState createState() => _ListCardViewState();
}

class _ListCardViewState extends State<ListCardView> {
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
              return ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: ProductDetails(
                              document: document,
                            ),
                            type: PageTransitionType.rightToLeftWithFade,
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      document['image'],
                                      height:
                                          Environment().getHeight(height: 3.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        AutoSizeText(
                                          ReCase(document['name']).titleCase,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 20.0,
                                          maxFontSize: 128.0,
                                        ),
                                        AutoSizeText(
                                          ReCase(document['category'])
                                              .sentenceCase,
                                          style: TextStyle(color: Colors.grey),
                                          minFontSize: 16.0,
                                          maxFontSize: 126.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Octicons.getIconData('primitive-dot'),
                                        color: Colors.orange[500],
                                      ),
                                      Text(
                                        'In Use: ${document['inUse'].toString()}',
                                        style: TextStyle(
                                          color: Colors.orange[500],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Octicons.getIconData('primitive-dot'),
                                        color: Colors.green[500],
                                      ),
                                      Text(
                                        'In Stock: ${document['inStock'].toString()}',
                                        style: TextStyle(
                                          color: Colors.green[500],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
