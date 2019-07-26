import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'env.dart';
import 'home_screen.dart';
import 'themes/helpers/theme_colors.dart';

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
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      child: Image.asset(
                        'assets/images/login_bg.jpg',
                      ),
                      height: 300),
                  Container(
                    height: 275.0,
                    color: Colors.black54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.content_cut,
                          size: 100.0,
                          color: whiteColor,
                        ),
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: whiteColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 230.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 6.0,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: FormBuilder(
                          key: _fbKey,
                          //autovalidate: true,
                          //readonly: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Enter your',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                    Text(
                                      'Email address',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 16.0, 0.0, 16.0),
                                child: Divider(
                                  color: cancelColor,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: Environment().getWidth(width: 45.0),
                                    child: FormBuilderTextField(
                                      keyboardType: TextInputType.emailAddress,
                                      attribute: 'email',
                                      decoration: InputDecoration(
                                        labelText: 'Email address',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      validators: [
                                        FormBuilderValidators.required(
                                            errorText:
                                                'Email address cannot be empty.'),
                                        FormBuilderValidators.email(
                                            errorText:
                                                'Email address need to be a valid email address.'),
                                        FormBuilderValidators.maxLength(30),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20.0,
                                      top: 20.0,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                          ),
                                          color: Colors.blue,
                                          onPressed: () {
                                            // showDialog(
                                            //   context: context,
                                            //   builder: (_) => EmailNotFoundDialog(),
                                            // );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        HomeScreen(),
                                              ),
                                            );
                                            _fbKey.currentState.save();
                                            if (_fbKey.currentState
                                                .validate()) {
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
                                              'Login',
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
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
