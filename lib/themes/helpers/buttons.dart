import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  CustomButton({
    @required this.onPressed,
    @required this.textButton,
    this.colorButton,
  });

  Color colorButton = Colors.black;
  final GestureTapCallback onPressed;
  String textButton;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      textColor: Colors.white,
      child: Text(widget.textButton),
      color: widget.colorButton,
      onPressed: widget.onPressed,
    );
  }
}
