import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/entypo.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:flutter_icons/simple_line_icons.dart';
import 'package:store_stockroom/env.dart';
import 'package:store_stockroom/themes/helpers/buttons.dart';
import 'package:store_stockroom/themes/helpers/fonts.dart';
import 'package:store_stockroom/themes/helpers/theme_colors.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Text('History'),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Select Date:'),
                    IconButton(
                      icon: Icon(SimpleLineIcons.getIconData("calendar")),
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2019, 1, 1), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 120,
                    child: Card(
                      elevation: 3.0,
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Icon(
                            Ionicons.getIconData("md-add-circle-outline"),
                            size: 40.0,
                            color: Colors.green,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text('Shampoo',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('by:', style: font15Grey),
                            Text('just now', style: font15Grey),
                            Text('action:', style: font15Grey)
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('200',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    child: Card(
                      elevation: 3.0,
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Icon(
                            Ionicons.getIconData("md-remove-circle-outline"),
                            size: 40.0,
                            color: removeColor,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text('Shampoo',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('by:', style: font15Grey),
                            Text('just now', style: font15Grey),
                            Text('action:', style: font15Grey)
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('10',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: removeColor,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
