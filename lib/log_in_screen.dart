import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'env.dart';

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
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          child: FormBuilder(
            key: _fbKey,
            //autovalidate: true,
            //readonly: false,
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
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Text(
                        'Enter your email address',
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: Environment().getWidth(width: 45.0),
                        child: FormBuilderTextField(
                          keyboardType: TextInputType.emailAddress,
                          attribute: 'email',
                          decoration: InputDecoration(
                            labelText: 'Email address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validators: [
                            FormBuilderValidators.required(
                                errorText: 'Email address cannot be empty.'),
                            FormBuilderValidators.email(
                                errorText:
                                    'Email address need to be a valid email address.'),
                            FormBuilderValidators.maxLength(30),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(24.0),
                            ),
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            _fbKey.currentState.save();
                            if (_fbKey.currentState.validate()) {
                              print(_fbKey.currentState.value);
                            } else {
                              print('validate failed');
                            }
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
                                fontSize: 18.0,
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
      ),
    );
  }
}
