import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PlaygroundScreen extends StatefulWidget {
  @override
  _PlaygroundScreenState createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  String barcode = '';

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Barcode Scanner Example'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: MaterialButton(
                  onPressed: scan,
                  child: Text('Scan'),
                ),
                padding: const EdgeInsets.all(8.0),
              ),
              Text(barcode),
              RaisedButton(
                child: Text('Take a Photo'),
                onPressed: () async {
                  await ImagePicker.pickImage(source: ImageSource.camera).then(
                    (file) async {
                      await ImageCropper.cropImage(
                        sourcePath: file.path,
                        toolbarTitle: 'Edit Photo',
                        toolbarColor: Colors.blue,
                        toolbarWidgetColor: Colors.white,
                        ratioX: 1.0,
                        ratioY: 1.0,
                        maxWidth: 512,
                        maxHeight: 512,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()  {
          },
        ),
      ),
    );
  }
}