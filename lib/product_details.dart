import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/octicons.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';
import 'dialogs/delete_dialog.dart';
import 'dialogs/edit_dialog.dart';
import 'env.dart';
import 'storage.dart';
import 'themes/helpers/fonts.dart' as ft;
import 'themes/helpers/theme_colors.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key key, @required this.document}) : super(key: key);

  final DocumentSnapshot document;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  SharedPreferences sharedPreferences;
  String token;

  bool _loadingState = false;

  @override
  void initState() {
    super.initState();
    _getSharePreference();
  }

  Future _getSharePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
  }

  void deleteProduct() async {
    Navigator.pop(context);
    setState(() {
      _loadingState = true;
    });
    await Storage()
        .deleteFile(
      collection: 'products',
      fileName:
          widget.document.data['created_at'].millisecondsSinceEpoch.toString(),
    )
        .whenComplete(() async {
      await Database().deleteCollection(
        collection: 'products',
        documentId: widget.document.documentID,
      );
    }).whenComplete(() async {
      await Database().createCollection(collection: 'product_history', data: {
        'action': 'deleted',
        'action description': 'deleted existing product from stock',
        'date': Timestamp.now(),
        'uid': token.trim(),
        'quantity': widget.document.data['in_stock'],
        'name': widget.document.data['name'],
        'category': widget.document.data['category'],
      });
    }).whenComplete(() {
      setState(() {
        _loadingState = false;
      });
    }).whenComplete(() {
      Navigator.pop(context);
    });
  }

  void editProduct(int value) async {
    Navigator.pop(context);
    setState(() {
      _loadingState = true;
    });
    await Database().updateCollection(
      collection: 'products',
      documentId: widget.document.documentID,
      data: {
        'in_stock': value + widget.document.data['in_stock'],
        'updated_at': Timestamp.now(),
      },
    ).whenComplete(() async {
      await Database().createCollection(collection: 'product_history', data: {
        'action': 'added',
        'action description': 'added more products into stock',
        'date': Timestamp.now(),
        'uid': token.trim(),
        'quantity': value,
        'name': widget.document.data['name'],
        'category': widget.document.data['category'],
      });
    }).whenComplete(() {
      _loadingState = false;
    }).whenComplete(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Product Details',
                style: ft.font20White,
              ),
            ),
          ],
        ),
      ),
      body: ModalProgressHUD(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.document.data['image'],
                      height: Environment().getHeight(height: 10.0),
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ReCase(widget.document.data['name']).titleCase,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ReCase(widget.document.data['category']).sentenceCase,
                        style: ft.font15Grey,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
                child: Divider(
                  color: Colors.black,
                  height: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Octicons.getIconData('primitive-dot'),
                          color: Colors.green[500],
                        ),
                        Text(
                          'In Stock: ${widget.document.data['in_stock'].toString()}',
                          style: TextStyle(
                            color: Colors.green[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Octicons.getIconData('primitive-dot'),
                          color: Colors.orange[500],
                        ),
                        Text(
                          'In Use: ${widget.document.data['in_use'].toString()}',
                          style: TextStyle(
                            color: Colors.orange[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
                child: Divider(
                  color: Colors.black,
                  height: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                child: Text(
                  'Description',
                  style: ft.font20Black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Text(widget.document['description'] == ''
                    ? ReCase('no description provided').sentenceCase
                    : ReCase(widget.document.data['description']).sentenceCase),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Created At: ' +
                              // 'Created at: 20/03/2019',
                              DateFormat('d MMM y')
                                  .format(widget.document.data['created_at']
                                      .toDate())
                                  .toString() +
                              '',
                          style: TextStyle(color: Colors.blue[500]),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Updated At: ' +
                              DateFormat('d MMM y')
                                  .format(widget.document.data['updated_at']
                                      .toDate())
                                  .toString() +
                              '',
                          style: TextStyle(color: Colors.green[500]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('employees')
                          .where(
                            'uid',
                            isEqualTo: widget.document.data['uid'],
                          )
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
                            return Text(
                                'By: ${ReCase(snapshot.data.documents.first['first_name'] + ' ' + snapshot.data.documents.first['last_name']).titleCase}');
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        inAsyncCall: _loadingState,
        progressIndicator: CircularProgressIndicator(),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            flex: 30,
            child: RaisedButton(
              padding: const EdgeInsets.all(15.0),
              textColor: Colors.white,
              color: removeColor,
              child: Text('Delete'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return DeleteDialog(
                        deleteCallBack: deleteProduct,
                      );
                    });
              },
            ),
          ),
          Expanded(
            flex: 70,
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Edit',
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return EditDialog(
                        onProductAdded: (int value) {
                          editProduct(value);
                        },
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
