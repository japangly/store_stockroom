import 'package:flutter/material.dart';
import 'package:store_stockroom/env.dart';
import 'package:store_stockroom/themes/helpers/fonts.dart';

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
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding:
          const EdgeInsets.only(top: 20.0, right: 20, left: 20, bottom: 0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 10),
          height: Environment().getHeight(height: 6),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.warning,
                    color: Colors.yellow,
                    size: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Duplicate Input!",
                      style: TextStyle(fontSize: 20, fontFamily: 'Avenir'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'The product is already exists.',
                      style: font15Grey,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
