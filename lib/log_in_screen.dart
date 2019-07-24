import 'package:flutter/material.dart';

import 'env.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

TextEditingController phoneTextController = TextEditingController();

class _LoginState extends State<LoginScreen> {
  String phoneNumber;
  bool validatePhoneNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.motorcycle,
                    size: 128.0,
                  ),
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: Environment().getWidth(width: 3.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      'Enter your Email',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      width: Environment().getWidth(width: 45.0),
                      child: TextFormField(
                        maxLength: 20,
                        textAlign: TextAlign.center,
                        controller: phoneTextController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            InputDecoration(hintText: 'XXXXXXX@gmail.com'),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(29.0),
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomeScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 30,
                            left: 30,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir',
                              fontSize: 20.0,
                            ),
                          ),
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
    );
  }
}
