import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/simple_line_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recase/recase.dart';

import 'database.dart';
import 'dialogs/duplicate_dialog.dart';
import 'themes/helpers/fonts.dart';

class CreateCategory extends StatefulWidget {
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  TextEditingController _category = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _savingState = false;

  void createNewCategory() async {
    setState(() {
      _savingState = true;
    });
    await Database().updateCollection(
      collection: 'category',
      documentId: 'products',
      data: {
        'category': FieldValue.arrayUnion([_category.text.toLowerCase().trim()])
      },
    ).whenComplete(() {
      _savingState = false;
    }).whenComplete(() {
      Navigator.pop(context);
    });
  }

  Future<bool> isDuplicationExists() async {
    bool isExists = false;
    setState(() {
      _savingState = true;
    });
    DocumentSnapshot category = await Database().getCollectionByDocumentId(
      collection: 'category',
      documentId: 'products',
    );
    for (String item in List.castFrom(category.data['category'])) {
      isExists = _category.text.toLowerCase().trim() == item;
    }
    setState(() {
      _savingState = false;
    });
    return isExists;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  ReCase('create new category').titleCase,
                  style: font20White,
                ),
              ),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          behavior: HitTestBehavior.translucent,
          child: ModalProgressHUD(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    SimpleLineIcons.getIconData('handbag'),
                    color: Colors.blue,
                    size: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Category',
                      style: font20Black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: TextFormField(
                      controller: _category,
                      maxLength: 1000,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: ReCase('category').titleCase,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return ReCase('please add the product category')
                              .sentenceCase;
                        }
                        return null;
                      },
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
                            padding: const EdgeInsets.all(16.0),
                            child: new Text(
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
                                  createNewCategory();
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
      ),
    );
  }
}
