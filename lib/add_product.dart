import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_stockroom/dialogs/add_category_dialog.dart';

import 'dialogs/duplicate_dialog.dart';
import 'env.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

String _selectedSort = 'Category';

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(MaterialIcons.getIconData("playlist-add")),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AddCategoryDialog(),
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
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: CircleAvatar(
                      radius: Environment().getHeight(height: 3),
                      backgroundImage: NetworkImage(
                        'https://cdn.shopify.com/s/files/1/0838/7991/products/Shampoo_copy.jpg?v=1547159160',
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Product Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(),
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
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20),
                          child: TextFormField(
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
                              left: 20.0, right: 20.0, top: 20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: TextFormField(
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
                                  icon:
                                      Icon(Ionicons.getIconData("ios-barcode")),
                                  onPressed: () {},
                                ),
                              ),
                            ],
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
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => DuplicateDialog(),
            );
          }),
    );
  }
}
