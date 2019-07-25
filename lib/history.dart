import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/simple_line_icons.dart';

import 'themes/helpers/theme_colors.dart';

int _listIndex = 0;
Icon defaultIcon = Icon(Icons.add, color: Colors.white);
Color defaultColor = confirmColor;
String defaultString = 'Added';
List<Icon> listIcon = [
  Icon(
    Icons.add,
    color: Colors.white,
  ),
  Icon(
    Icons.remove,
    color: Colors.white,
  ),
];
List<Color> listColor = [
  confirmColor,
  removeColor,
];
List<String> listString = [
  'Added',
  'Deleted',
  'Deleted',
  'Added',
  'Added',
];

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                defaultString = listString[index];
                defaultString == 'Added'
                    ? defaultColor = listColor[0]
                    : defaultColor = listColor[1];
                    
                defaultString == 'Added'
                    ? defaultIcon = listIcon[0]
                    : defaultIcon = listIcon[1];
                return HistoryCardView();
              },
            ),
          )
        ],
      ),
    );
  }
}

class HistoryCardView extends StatelessWidget {
  const HistoryCardView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AutoSizeText(
                              'Head & Shoulder',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              minFontSize: 8.0,
                              maxFontSize: 256.0,
                            ),
                            AutoSizeText(
                              'Shampoo',
                              minFontSize: 8.0,
                              maxFontSize: 256.0,
                            ),
                            Divider(
                              color: cancelColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    AutoSizeText(
                                      'Just now',
                                      minFontSize: 8.0,
                                      maxFontSize: 128.0,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: AutoSizeText(
                                        '12/12/2019',
                                        style: TextStyle(),
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
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: AutoSizeText(
                                            'Bunseng',
                                            style: TextStyle(),
                                            minFontSize: 8.0,
                                            maxFontSize: 128.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    AutoSizeText(
                                      'Action',
                                      minFontSize: 8.0,
                                      maxFontSize: 128.0,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: AutoSizeText(
                                        defaultString,
                                        style: TextStyle(),
                                        minFontSize: 8.0,
                                        maxFontSize: 128.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              height: 64.0,
              width: 64.0,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(128.0),
                )),
                color: defaultColor,
                elevation: 6.0,
                child: defaultIcon,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
