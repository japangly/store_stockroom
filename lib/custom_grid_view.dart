import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_stockroom/product_details.dart';

import 'env.dart';

class CardGridView extends StatefulWidget {
  @override
  _CardGridViewState createState() => _CardGridViewState();
}

class _CardGridViewState extends State<CardGridView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
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
                                  'https://www.superdrug.com/medias/sys_master/front-zoom/front-zoom/hdd/h56/9790451974174/Head-Shoulders-Supreme-Smooth-Shampoo-400ml-748816.jpg'),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                child: AutoSizeText(
                                  'Head & Shoulder',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 8.0,
                                  maxFontSize: 128.0,
                                ),
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  'Shampoo',
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
                                      children: <Widget>[
                                        AutoSizeText(
                                          'In Service',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          minFontSize: 8.0,
                                          maxFontSize: 128.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: AutoSizeText(
                                            '12',
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
                                        AutoSizeText(
                                          'In Stock',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          minFontSize: 8.0,
                                          maxFontSize: 128.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: AutoSizeText(
                                            '12',
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
                          child: ProductDetails(),
                          type: PageTransitionType.rightToLeftWithFade),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
