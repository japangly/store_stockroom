import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:store_stockroom/themes/helpers/theme_colors.dart' as prefix0;

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
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5],
                  colors: [Colors.blue, Colors.white])),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset(
                    'assets/images/login.jpg',
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, right: 30.0, left: 30.0, bottom: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                          fontFamily: 'Realistica',
                          fontSize: 30.0,
                          color: blueColor[900]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 90.0),
                      child: Text(
                        'Login to continue',
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                    ),
                    FormBuilderTextField(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: FormBuilderTextField(
                        keyboardType: TextInputType.emailAddress,
                        attribute: 'password',
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "Proceed",
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
