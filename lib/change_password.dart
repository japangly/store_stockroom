import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dialogs/fail_dialog.dart';
import 'functions/auth.dart';
import 'successful_change.dart';
import 'themes/helpers/theme_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  SharedPreferences sharedPreferences;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loadingState = false;
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _oldPassword = TextEditingController();
  TextEditingController _retypeNewPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getSharePreference();
  }

  Future _getSharePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

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
              stops: [0.1, 0.3],
              colors: [
                Colors.blue,
                Colors.white,
              ],
            ),
          ),
          child: ModalProgressHUD(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 100.0,
                  right: 30.0,
                  left: 30.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ReCase('change password').titleCase,
                        style: TextStyle(
                            fontFamily: 'Realistica',
                            fontSize: 30.0,
                            color: blueColor[900]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: TextFormField(
                          controller: _oldPassword,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: ReCase('old password').titleCase,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ReCase(
                                'please enter your old password',
                              ).sentenceCase;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: TextFormField(
                          controller: _newPassword,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: ReCase('new password').titleCase,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ReCase(
                                'please enter your new password',
                              ).sentenceCase;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: TextFormField(
                          controller: _retypeNewPassword,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: ReCase('retype new password').titleCase,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ReCase(
                                'please reenter your new password',
                              ).sentenceCase;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 10.0,
                        ),
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
                                    Text(
                                      ReCase('change').titleCase,
                                    ),
                                    Icon(Icons.arrow_forward)
                                  ],
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    if (_newPassword.text ==
                                        _retypeNewPassword.text) {
                                      setState(() {
                                        _loadingState = true;
                                      });
                                      await Authentication().signIn(
                                                email: sharedPreferences
                                                    .getString('email'),
                                                password: _oldPassword.text,
                                              ) !=
                                              null
                                          ? (await Authentication()
                                                  .changePassword(
                                              newPassword: _newPassword.text,
                                            )
                                              ? sharedPreferences
                                                  .clear()
                                                  .whenComplete(() {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return SuccessChangedScreen();
                                                      },
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                })
                                              : showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return FailDialog();
                                                  }))
                                          : showDialog(
                                              context: context,
                                              builder: (_) {
                                                return FailDialog();
                                              });
                                      setState(() {
                                        _loadingState = false;
                                      });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return FailDialog();
                                          });
                                    }
                                  }
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
            inAsyncCall: _loadingState,
            progressIndicator: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
