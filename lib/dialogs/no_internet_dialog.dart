import 'dart:io';

import 'package:flutter/material.dart';

import '../env.dart';
import '../themes/helpers/buttons.dart';
import '../themes/helpers/fonts.dart';
import '../themes/helpers/theme_colors.dart';

class NoInternetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 10),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'No Internet Connection!',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Avenir',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: Text(
                      'Please check your internet connection and try again.',
                      style: font15Grey,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              CustomButton(
                textButton: 'Exit',
                colorButton: removeColor,
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
