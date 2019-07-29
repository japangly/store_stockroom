import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'themes/helpers/theme_colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

TextEditingController phoneTextController = TextEditingController();

class _LoginState extends State<ResetPasswordScreen> {
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
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.3],
                  colors: [Colors.blue, Colors.white])),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 200.0, right: 30.0, left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Reset Password',
                    style: TextStyle(
                        fontFamily: 'Realistica',
                        fontSize: 30.0,
                        color: blueColor[900]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "Reset",
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
          ),
        ),
      ),
    );
  }
}
