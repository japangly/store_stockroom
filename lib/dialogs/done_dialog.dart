import 'package:flutter/material.dart';

import '../env.dart';
import '../themes/helpers/theme_colors.dart';

class DoneDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding:
          const EdgeInsets.only(top: 20.0, right: 20, left: 20, bottom: 0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 10.0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                    size: 50,
                    color: confirmColor,
                  ),
                  Text(
                    'Done!',
                    style: TextStyle(fontSize: 20.0),
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
