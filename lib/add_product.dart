import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'add_category.dart';
import 'env.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text('Add Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(MaterialIcons.getIconData("playlist-add")),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AddCategory(),
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
            child: FormBuilder(
              key: _fbKey,
              //autovalidate: true,
              //readonly: false,
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20),
                        child: FormBuilderTextField(
                          keyboardType: TextInputType.text,
                          attribute: 'product_name',
                          decoration: InputDecoration(
                            labelText: 'Product Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validators: [
                            FormBuilderValidators.required(
                                errorText: 'Product name cannot be empty.'),
                            FormBuilderValidators.maxLength(50),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                        child: FormBuilderDropdown(
                          attribute: "category",
                          decoration: InputDecoration(labelText: "Category"),
                          hint: Text('Select Category'),
                          validators: [
                            FormBuilderValidators.required(
                                errorText: 'Category cannot be empty.')
                          ],
                          items: ['Shampoo', 'Conditioner']
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text('$category'),
                                  ))
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: FormBuilderTextField(
                          keyboardType: TextInputType.number,
                          attribute: 'quantity',
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          valueTransformer: (text) => num.tryParse(text),
                          validators: [
                            FormBuilderValidators.required(
                                errorText: 'Quantity cannot be empty.'),
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.max(1000),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: FormBuilderTextField(
                                keyboardType: TextInputType.text,
                                attribute: 'barcode',
                                decoration: InputDecoration(
                                  labelText: 'Barcode',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                validators: [
                                  FormBuilderValidators.required(
                                      errorText: 'Barcode cannot be empty.'),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon:
                                      Icon(Ionicons.getIconData("ios-barcode")),
                                  onPressed: () {},
                                )),
                          ],
                        ),
                      ),
                      new ClipRRect(
                        borderRadius: new BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://mocdn.gs1.org/sites/default/files/docs/barcodes/ITF-14.png',
                          height: 200.0,
                          width: 150.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fbKey.currentState.save();
          if (_fbKey.currentState.validate()) {
            print(_fbKey.currentState.value);
          } else {
            print('validate failed');
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
