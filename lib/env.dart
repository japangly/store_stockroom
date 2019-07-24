import 'package:flutter_device_type/flutter_device_type.dart';

class Environment {
  double getHeight({double height = 100.0}) {
    return (Device.height * height) / 100.0;
  }

  double getWidth({double width = 100.0}) {
    return (Device.width * width) / 100.0;
  }
}
