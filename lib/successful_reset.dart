import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:recase/recase.dart';
import 'package:store_stockroom/log_in_screen.dart';
import 'package:store_stockroom/themes/helpers/theme_colors.dart' as prefix0;

import 'themes/helpers/theme_colors.dart';

class SuccessResetScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<SuccessResetScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.3,
              ],
              colors: [
                Colors.blue,
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  ReCase('successful password reset!').sentenceCase,
                  style: TextStyle(
                      fontFamily: 'Realistica',
                      fontSize: 20.0,
                      color: blueColor[900]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
                  child: Text(
                    ReCase('to reset your password follow the link in your mailbox and set a new password!')
                        .sentenceCase,
                    style: TextStyle(fontSize: 15.0, color: prefix0.blackColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          textColor: Colors.white,
                          color: Colors.blue,
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                ReCase('login').titleCase,
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
