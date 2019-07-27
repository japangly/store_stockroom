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
        'barcode': _barCode.text.toLowerCase().trim(),
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

  dynamic checkDuplication() async {
    return await Database().getCollectionByField(
        collection: 'products',
        field: 'name',
        value: _productName.text.toLowerCase().trim());
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this._barCode.text = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._barCode.text = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this._barCode.text = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this._barCode.text =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this._barCode.text = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create New Product'),
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
                            labelText: 'Product Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ReCase('please enter the product name')
                                  .sentenceCase;
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
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          hint: Text(_selectedSort),
                          items: ['shampoo', 'conditioner']
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(ReCase(category).titleCase),
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
                                      'please select a category or create a new one')
                                  .sentenceCase;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 16.0,
                        ),
                        child: TextFormField(
                          controller: _inStock,
                          maxLength: 1000,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ReCase('please enter the product quantity')
                                  .sentenceCase;
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
                            labelText: 'Description',
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
                                  labelText: 'Barcode',
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              createNewProduct();
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
