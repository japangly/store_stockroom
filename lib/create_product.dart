import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
  String _selectedSort = 'Category';

  void createNewProduct() async {
    Database().createCollection(
      collection: 'products',
      data: {
        'id': _barCode.text.toLowerCase().trim(),
        'name': _productName.text.toLowerCase().trim(),
        'category': _selectedSort.toString().toLowerCase().trim(),
        'inStock': int.parse(_inStock.text.trim()),
        'description': _description.text.toLowerCase().trim(),
        'createdAt': Timestamp.now(),
        'image': await Storage().uploadFile(
          collection: 'products',
          fileName: Timestamp.now().millisecondsSinceEpoch.toString(),
          file: widget.imageFile,
        ),
        'inUse': 0,
        'salePrice': 0,
        'soldPrice': 0,
        'soldOut': 0,
        'updatedAt': Timestamp.now(),
        'isPriceSet': false,
      },
    );
  }

  dynamic checkDuplication() async {
    return await Database().getCollectionByField(
        collection: 'products',
        field: 'name',
        value: _productName.text.toLowerCase().trim());
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
            onPressed: () {},
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.translucent,
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
                            return 'Please Enter the Product Name';
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
                        items: ['Shampoo', 'Conditioner']
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        onChanged: (selected) {
                          setState(() {
                            _selectedSort = selected;
                          });
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
                              return 'Please Enter the Product Quantity';
                            }
                            return null;
                          }),
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
                        keyboardType: TextInputType.text,
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
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 64.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            print('validate');
          }
        },
      ),
    );
  }
}
