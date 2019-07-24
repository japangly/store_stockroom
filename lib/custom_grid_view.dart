import 'package:flutter/material.dart';

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
          return Card(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Head &Shoulder',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Environment().getHeight(height: 1),
                              ),
                            ),
                            Text(
                              'Shampo',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: Environment().getHeight(height: 0.8),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'In Service',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Environment()
                                            .getHeight(height: 0.8),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        '12',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Environment()
                                              .getHeight(height: 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'In Stock',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Environment()
                                            .getHeight(height: 0.8),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        '12',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Environment()
                                              .getHeight(height: 1),
                                        ),
                                      ),
                                    ),
                                  ],
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
                    MaterialPageRoute(
                      builder: (BuildContext context) {},
                    ),
                  );
                },
                onLongPress: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
