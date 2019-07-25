import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_stockroom/product_details.dart';

List<Widget> ok = [
  Text('Create At'),
  Text('Category'),
  Text('In Stock'),
  Text('In Service'),
];

class CardListView extends StatefulWidget {
  @override
  _CardListViewState createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: ProductDetails(),
                      type: PageTransitionType.rightToLeftWithFade),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AutoSizeText(
                            'Head & Shoulder',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            minFontSize: 8.0,
                            maxFontSize: 128.0,
                          ),
                          AutoSizeText(
                            'Shampoo',
                            style: TextStyle(),
                            minFontSize: 8.0,
                            maxFontSize: 128.0,
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              AutoSizeText(
                                'Create At',
                                minFontSize: 8.0,
                                maxFontSize: 128.0,
                              ),
                              AutoSizeText(
                                '12/12/2019',
                                style: TextStyle(),
                                minFontSize: 8.0,
                                maxFontSize: 128.0,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              AutoSizeText(
                                'In Service',
                                minFontSize: 8.0,
                                maxFontSize: 128.0,
                              ),
                              Row(
                                children: <Widget>[
                                  AutoSizeText(
                                    '12',
                                    style: TextStyle(),
                                    minFontSize: 8.0,
                                    maxFontSize: 128.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              AutoSizeText(
                                'In Stock',
                                minFontSize: 8.0,
                                maxFontSize: 128.0,
                              ),
                              AutoSizeText(
                                '12',
                                style: TextStyle(),
                                minFontSize: 8.0,
                                maxFontSize: 128.0,
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
          ),
        ],
      ),
    );
  }
}
