import 'package:flutter/material.dart';

class PlaygroundScreen extends StatefulWidget {
  @override
  _PlaygroundScreenState createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('text'),
        ),
        body: Center(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
      ),
    );
  }
}
