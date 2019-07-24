import 'package:flutter/material.dart';
import 'package:store_stockroom/env.dart';
import 'package:store_stockroom/themes/helpers/fonts.dart';
import 'package:store_stockroom/themes/helpers/theme_colors.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: RaisedButton(
      child: Text('Open Dialog'),
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) {
              return MyDialog();
            });
      },
    )));
  }
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
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
          width: Environment().getWidth(width: 18),
          height: Environment().getHeight(height: 15),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    color: removeColor,
                    size: 80.0,
                  ),
                  Text(
                    "Phone Number Not Found",
                    style: TextStyle(fontSize: 30, fontFamily: 'Avenir'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "You may have not registered yet.",
                      style: font20Grey,
                    ),
                  ),
                  Text(
                    "Please contact your HR!",
                    style: font20Grey,
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
