import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dialogs/email_password_not_found_dialog.dart';
import 'env.dart';
import 'functions/auth.dart';
import 'home_screen.dart';
import 'reset_password.dart';
import 'themes/helpers/fonts.dart';
import 'themes/helpers/theme_colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loadingState = false;
  TextEditingController _password = TextEditingController();

  Future signIn(BuildContext context) async {
    setState(() {
      _loadingState = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await Authentication()
        .signIn(
      email: _email.text.toLowerCase().trim(),
      password: _password.text,
    )
        .then((token) {
      sharedPreferences.setString(
        'token',
        token,
      );
      sharedPreferences.setString(
        'email',
        _email.text.toLowerCase().trim(),
      );
    }).whenComplete(() {
      setState(() {
        _loadingState = false;
      });
    }).whenComplete(() {
      sharedPreferences.getString('token') != null
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return HomeScreen();
                },
              ),
            )
          : showDialog(
              context: context,
              builder: (_) {
                return EmailPasswordNotFoundDialog();
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ModalProgressHUD(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.4],
                colors: [Colors.blue, Colors.white],
              ),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 100.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ReCase('welcome back').titleCase,
                            style: TextStyle(
                                fontFamily: 'Realistica',
                                fontSize: 30.0,
                                color: blueColor[900]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: Text(
                              ReCase('login to continue').sentenceCase,
                              style:
                                  TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                          ),
                          TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: ReCase('email').titleCase,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return ReCase(
                                  'please enter your email address',
                                ).sentenceCase;
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(
                              controller: _password,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: ReCase('password').titleCase,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return ReCase(
                                    'please enter your password',
                                  ).sentenceCase;
                                }
                                return null;
                              },
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
                                      ),
                                    ),
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'proceed'.toUpperCase(),
                                        ),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        await signIn(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 30.0),
                            child: Column(
                              children: <Widget>[
                                FlatButton(
                                  child: Text(
                                    ReCase('forgot password?').titleCase,
                                    style: font15Grey,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return ResetPasswordScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/login.png',
                                  height: Environment().getHeight(height: 8),
                                )
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
          ),
        ),
        inAsyncCall: _loadingState,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }
}
