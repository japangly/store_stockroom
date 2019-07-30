import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recase/recase.dart';

import 'create_category.dart';
import 'database.dart';
import 'dialogs/camera_dialog.dart';
import 'dialogs/duplicate_dialog.dart';
import 'dialogs/error_dialog.dart';
import 'env.dart';
import 'storage.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key key, @required this.imageFile}) : super(key: key);

  final File imageFile;

  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  TextEditingController _barCode = TextEditingController();
  List<String> _categoryList = [];
  TextEditingController _description = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _inStock = TextEditingController();
  TextEditingController _productName = TextEditingController();
  bool _savingState = false;
  String _selectedSort = 'Category';

  void createNewProduct() async {
    setState(() {
      _savingState = true;
    });
    await Database().createCollection(
      collection: 'products',
      data: {
        'barcode': _barCode.text.isNotEmpty
            ? _barCode.text.toLowerCase().trim()
            : Timestamp.now().millisecondsSinceEpoch.toString(),
        'name': _productName.text.toLowerCase().trim(),
        'category': _selectedSort.toString().toLowerCase().trim(),
        'in stock': int.parse(_inStock.text.trim()),
        'description': _description.text.toLowerCase().trim(),
        'created at': Timestamp.now(),
        'image': await Storage().uploadFile(
          collection: 'products',
          fileName: Timestamp.now().millisecondsSinceEpoch.toString(),
          file: widget.imageFile,
        ),
        'in use': 0,
        'sale price': 0,
        'sold price': 0,
        'sold out': 0,
        'updated at': Timestamp.now(),
        'is price set': false,
      },
    ).whenComplete(() async {
      await Database().createCollection(collection: 'product_history', data: {
        'action': 'created',
        'action description': 'created a new product',
        'employee first name': 'japang',
        'employee last name': 'ly',
        'date': Timestamp.now(),
        'employee id': '00000001',
        'quantity': int.parse(_inStock.text.trim()),
        'product name': _productName.text.toLowerCase().trim(),
        'product category': _selectedSort.toString().toLowerCase().trim(),
      });
    }).whenComplete(() {
      setState(() {
        _savingState = false;
      });
    }).whenComplete(() {
      Navigator.pop(context);
    });
  }

  Future<bool> isDuplicationExists() async {
    DocumentSnapshot name, barcode;
    setState(() {
      _savingState = true;
    });
    name = await Database()
        .getCollectionByField(
      collection: 'products',
      field: 'name',
      value: _productName.text.toLowerCase().trim(),
    )
        .whenComplete(() async {
      barcode = await Database().getCollectionByField(
        collection: 'products',
        field: 'barcode',
        value: _barCode.text.toLowerCase().trim(),
      );
    }).whenComplete(() {
      setState(() {
        _savingState = false;
      });
    });
    return name != null || barcode != null;
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        return this._barCode.text = barcode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showDialog(
            context: context,
            builder: (_) {
              return CameraDialog();
            });
      } else {
        showDialog(
            context: context,
            builder: (_) {
              return ErrorDialog();
            });
      }
    } on FormatException {
      // FormatException to be handled
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) {
            return ErrorDialog();
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(ReCase('create new product').titleCase),
        actions: <Widget>[
          IconButton(
            icon: Icon(MaterialIcons.getIconData('playlist-add')),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CreateCategory();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.translucent,
        child: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: CircleAvatar(
                      radius: Environment().getHeight(height: 3),
                      backgroundImage: FileImage(widget.imageFile),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 20.0,
                        ),
                        child: TextFormField(
                          controller: _productName,
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: ReCase('product name').titleCase,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ReCase(
                                'please enter the product name',
                              ).sentenceCase;
                            }
                            return null;
                          },
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: Database().getStreamCollection(
                            collection: 'category',
                            orderBy: 'name',
                            isDescending: false,
                          ),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot,
                          ) {
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            else {
                              _categoryList = List<String>.from(
                                  snapshot.data.documents.first['category']);
                              _categoryList.sort();
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 8.0,
                                ),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  hint: Text(_selectedSort),
                                  items: _categoryList
                                      .map((category) => DropdownMenuItem(
                                            value: ReCase(category).titleCase,
                                            child: Text(
                                                ReCase(category).titleCase),
                                          ))
                                      .toList(),
                                  onChanged: (selected) {
                                    setState(() {
                                      _selectedSort = selected;
                                    });
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return ReCase(
                                        'please select a category or create a new one',
                                      ).sentenceCase;
                                    }
                                    return null;
                                  },
                                ),
                              );
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 16.0,
                        ),
                        child: TextFormField(
                          controller: _inStock,
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: ReCase('quantity').titleCase,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ReCase(
                                'please enter the product quantity',
                              ).sentenceCase;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 8.0,
                        ),
                        child: TextFormField(
                          controller: _description,
                          maxLength: 1000,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: ReCase('description').titleCase,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 8.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                controller: _barCode,
                                keyboardType: TextInputType.text,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: ReCase('barcode').titleCase,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(
                                  Ionicons.getIconData('ios-barcode'),
                                ),
                                onPressed: scan,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          )),
                          textColor: Colors.white,
                          color: Colors.blue,
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            ReCase('create').titleCase,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (await isDuplicationExists()) {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return DuplicateDialog();
                                    });
                              } else {
                                createNewProduct();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          inAsyncCall: _savingState,
          progressIndicator: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
