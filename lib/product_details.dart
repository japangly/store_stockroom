import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/octicons.dart';
import 'package:intl/intl.dart';
import 'package:store_stockroom/dialogs/delete_dialog.dart';
import 'package:store_stockroom/themes/helpers/theme_colors.dart' as prefix0;

import 'dialogs/edit_dialog.dart';
import 'env.dart';
import 'themes/helpers/fonts.dart' as ft;
import 'themes/helpers/theme_colors.dart';

class ProductDetails extends StatefulWidget {
  final DocumentSnapshot document;
  ProductDetails({Key key, @required this.document}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                decoration:
                    BoxDecoration(color: prefix0.whiteColor, boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                  ),
                ]),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(widget.document.data['image'],
                      height: Environment().getHeight(height: 10.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              child: Text(
                widget.document.data['name'],
                style: TextStyle(
                    fontSize: 20.0,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 10.0),
              child: Text(
                widget.document.data['category'],
                style: ft.font15Grey,
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
                        Octicons.getIconData("primitive-dot"),
                        color: Colors.green[500],
                      ),
                      Text(
                        'In Stock: ${widget.document.data['inStock'].toString()}',
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
                        Octicons.getIconData("primitive-dot"),
                        color: Colors.orange[500],
                      ),
                      Text(
                        'In Use: ${widget.document.data['inUse'].toString()}',
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
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              child: Text(
                'Description',
                style: ft.font20Black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text(widget.document.data['description']),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Created at: ' +
                            // 'Created at: 20/03/2019',
                            DateFormat("d MMM y")
                                .format(
                                    widget.document.data['createdAt'].toDate())
                                .toString() +
                            '',
                        style: TextStyle(color: Colors.blue[500]),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Updated at: ' +
                            DateFormat("d MMM y")
                                .format(
                                    widget.document.data['updatedAt'].toDate())
                                .toString() +
                            '',
                        style: TextStyle(color: Colors.green[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            flex: 30,
            child: RaisedButton(
              padding: const EdgeInsets.all(15.0),
              textColor: Colors.white,
              color: removeColor,
              child: Text("Delete"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return DeleteDialog(
                        documentId: widget.document.documentID,
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
                "Edit",
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return EditDialog(
                        documentId: widget.document.documentID,
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
