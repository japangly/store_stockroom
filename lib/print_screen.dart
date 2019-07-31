import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/simple_line_icons.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

import 'dialogs/print_dialog.dart';
import 'themes/helpers/buttons.dart';
import 'themes/helpers/fonts.dart';
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
                  ReCase('print report').titleCase,
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
                    SimpleLineIcons.getIconData('printer'),
                    color: Colors.blue,
                    size: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      ReCase('choose a date!').titleCase,
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
                                onConfirm: (date) async {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return PrintDialog(
                                      dateTime: date,
                                      selectedDate: ReCase(
                                              DateFormat('yMMMMEEEEd')
                                                  .format(date)
                                                  .toString())
                                          .titleCase,
                                    );
                                  });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          textButton: ReCase('another day').titleCase,
                          colorButton: cancelColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return PrintDialog(
                                    dateTime: DateTime.now(),
                                    selectedDate: ReCase(DateFormat('yMMMMEEEEd')
                                            .format(DateTime.now())
                                            .toString())
                                        .titleCase,
                                  );
                                });
                          },
                          textButton: ReCase('today').titleCase,
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
