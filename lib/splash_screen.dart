import 'package:flutter/material.dart';
import 'package:store_stockroom/env.dart';
import 'package:store_stockroom/log_in_screen.dart';

import 'themes/helpers/splash_screen_plugin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenStyles(
      seconds: 5,
      navigateAfterSeconds: LoginScreen(),
      backgroundColor: Colors.blue,
      photoSize: Environment().getHeight(height: 8.0),
      title: Text(
        'Mickey & Honey',
        style: TextStyle(color: Colors.white, fontSize: 24.0),
      ),
      loaderColor: Colors.white,
    );
  }
}
