import 'package:flutter/material.dart';
import 'package:store_stockroom/env.dart';
import 'package:store_stockroom/log_in_screen.dart';
import 'package:store_stockroom/themes/helpers/fonts.dart';
// import 'package:store_stockroom/themes/helpers/theme_colors.dart';

import 'themes/helpers/splash_screen_plugin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenStyles(
      seconds: 3,
      navigateAfterSeconds: LoginScreen(),
      backgroundColor: Colors.blue,
      photoSize: Environment().getHeight(height: 6.0),
      // image: Image.asset('assets/images/icon_salon.png'),
      title: Text(
        'Mickey &Honey',
        style: font30White,
      ),
      loaderColor: Colors.blue,
    );
  }
}
