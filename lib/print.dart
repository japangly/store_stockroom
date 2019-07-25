import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/simple_line_icons.dart';
import 'package:store_stockroom/dialogs/print_dialog.dart';
import 'package:store_stockroom/themes/helpers/buttons.dart';
import 'package:store_stockroom/themes/helpers/fonts.dart';
import 'themes/helpers/theme_colors.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'Print Report',
                  style: font20White,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    SimpleLineIcons.getIconData("printer"),
                    color: Colors.blue,
                    size: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Choose a date!",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2019, 1, 1),
                                onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return PrintDialog(
                                      selectedDay: date,
                                    );
                                  });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          textButton: 'Another Day',
                          colorButton: cancelColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return PrintDialog(
                                    selectedDay: DateTime.now(),
                                  );
                                });
                          },
                          textButton: 'Today',
                          colorButton: blueColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
