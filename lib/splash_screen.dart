import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_stockroom/log_in_screen.dart';

import 'home_screen.dart';
import 'themes/helpers/buttons.dart';
import 'themes/helpers/fonts.dart';
import 'themes/helpers/splash_screen_plugin.dart';
import 'themes/helpers/theme_colors.dart';
import 'main.dart' as global;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenStyles(
      seconds: 3,
      navigateAfterSeconds: DecisionRoute(),
      imageBackground: AssetImage('assets/images/splash_screen.jpg'),
      title: Text(
        'Mickey & Honey',
        style: TextStyle(
          fontFamily: 'Realistica',
          color: whiteColor,
          fontSize: 40,
        ),
      ),
      loaderColor: Colors.transparent,
    );
  }
}

class DecisionRoute extends StatefulWidget {
  @override
  _DecisionRouteState createState() => _DecisionRouteState();
}

class _DecisionRouteState extends State<DecisionRoute> {
  bool connectionStatus = false;
  SharedPreferences sharedPreferences;
  String token;

  @override
  void initState() {
    super.initState();
    _getSharePreference();
  }

  Future<bool> checkInternetConnection() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      connectionStatus = true;
      return true;
    } else {
      connectionStatus = false;
      return false;
    }
  }

  Future _getSharePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkInternetConnection(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return connectionStatus == false
            ? NoInternetScreen()
            : token.isNotEmpty ? HomeScreen() : LoginScreen();
      },
    );
  }
}

class NoInternetScreen extends StatefulWidget {
  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('store_stockroom'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: AutoSizeText(
                          'No Internet Connection!',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Avenir',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: AutoSizeText(
                          'Please check your internet connection and try again.',
                          style: font15Grey,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  CustomButton(
                    textButton: 'Exit',
                    colorButton: removeColor,
                    onPressed: () {
                      exit(0);
                    },
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
