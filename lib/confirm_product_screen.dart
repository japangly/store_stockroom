import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/simple_line_icons.dart';
import 'package:recase/recase.dart';
import 'package:store_stockroom/themes/helpers/theme_colors.dart';

class ConfirmProductScreen extends StatefulWidget {
  @override
  _ConfirmProductScreenState createState() => _ConfirmProductScreenState();
}

class _ConfirmProductScreenState extends State<ConfirmProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(ReCase('select date:').titleCase),
              IconButton(
                icon: Icon(SimpleLineIcons.getIconData('calendar')),
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2019, 1, 1),
                    onConfirm: (date) {
                      setState(() {});
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  'shampoo',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  minFontSize: 20.0,
                                  maxFontSize: 256.0,
                                ),
                                AutoSizeText(
                                  'beauty care',
                                  style: TextStyle(color: Colors.grey),
                                  minFontSize: 8.0,
                                  maxFontSize: 256.0,
                                ),
                                Divider(
                                  color: cancelColor,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        AutoSizeText(
                                          ReCase('date').titleCase,
                                          minFontSize: 8.0,
                                          maxFontSize: 128.0,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: AutoSizeText(
                                            '20/20/2019',
                                            minFontSize: 8.0,
                                            maxFontSize: 128.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        AutoSizeText(
                                          'By',
                                          minFontSize: 8.0,
                                          maxFontSize: 128.0,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: AutoSizeText(
                                            'Johnathan',
                                            minFontSize: 8.0,
                                            maxFontSize: 128.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            color: removeColor,
                                          ),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.check_circle_outline,
                                            color: confirmColor,
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                '200',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                minFontSize: 20.0,
                                maxFontSize: 256.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
