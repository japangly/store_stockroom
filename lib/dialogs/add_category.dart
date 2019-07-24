import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:store_stockroom/themes/helpers/buttons.dart';
import 'package:store_stockroom/themes/helpers/fonts.dart';
import 'package:store_stockroom/themes/helpers/theme_colors.dart';

import '../env.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => new _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding:
          const EdgeInsets.only(top: 40.0, right: 50, left: 50, bottom: 0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 15),
          height: Environment().getHeight(height: 8),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Add Category",
                    style: font20Grey,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
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
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(
                      onPressed: () {},
                      textButton: 'Add',
                      colorButton: blueColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
