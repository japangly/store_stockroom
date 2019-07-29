import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../env.dart';
import '../themes/helpers/buttons.dart';
import '../themes/helpers/fonts.dart';
import '../themes/helpers/theme_colors.dart';

class EditDialog extends StatefulWidget {
  EditDialog({Key key, @required this.onProductAdded}) : super(key: key);

  final ValueChanged<int> onProductAdded;

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _inStock = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding:
          const EdgeInsets.only(top: 20.0, right: 40, left: 40, bottom: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 10.0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Edit Product',
                    style: font20Black,
                  )
                ],
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                      style: font15Grey,
                      controller: _inStock,
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
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
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(
                      textButton: 'Save',
                      colorButton: confirmColor,
                      onPressed: () {
                        widget.onProductAdded(int.parse(_inStock.text.trim()));
                      },
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
