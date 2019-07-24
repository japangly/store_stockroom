import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    @required this.onPressed,
    @required this.textButton,
    this.colorButton,
  });

  Color colorButton = Colors.black;
  final GestureTapCallback onPressed;
  String textButton;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      textColor: Colors.white,
      child: Text(textButton),
      color: colorButton,
      onPressed: onPressed,
    );
  }
}
