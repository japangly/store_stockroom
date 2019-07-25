import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/octicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_stockroom/product_details.dart';

import 'env.dart';

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
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFZ1T_DlCjC2KZNwXCJc80wIsWoSJDWDr3bGInOsuVMhDelJKC',
                              height: Environment().getHeight(height: 3.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  'Head & Shoulder',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 20.0,
                                  maxFontSize: 128.0,
                                ),
                                AutoSizeText(
                                  'Shampoo',
                                  style: TextStyle(color: Colors.grey),
                                  minFontSize: 18.0,
                                  maxFontSize: 128.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Octicons.getIconData("primitive-dot"),
                                color: Colors.orange[500],
                              ),
                              Text(
                                'In Use: 10',
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
                                Octicons.getIconData("primitive-dot"),
                                color: Colors.green[500],
                              ),
                              Text(
                                'In Stock: 300',
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
          ),
        ],
      ),
    );
  }
}
