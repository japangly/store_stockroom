import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/simple_line_icons.dart';
import 'package:store_stockroom/themes/helpers/fonts.dart';

class CreateCategory extends StatefulWidget {
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'Create New Category',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    SimpleLineIcons.getIconData("handbag"),
                    color: Colors.blue,
                    size: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Category",
                      style: font20Black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    child: FormBuilderTextField(
                      attribute: "category", style: font15Grey,
                      decoration: InputDecoration(
                        labelText: "Category Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      // onChanged: _onChanged,
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
                            child: new Text(
                              "Create",
                            ),
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
        ),
      ),
    );
  }
}
