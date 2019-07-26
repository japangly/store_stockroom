import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'grid_card_view.dart';
import 'list_card_view.dart';

String _selectedSortBy = 'name';
String _selectedShownBy = 'descending';
bool _isDescending = false;

int _widgetIndex = 0;
List<Widget> _displayWidget = <Widget>[
  ListCardView(selectedSortBy: _selectedSortBy, selectedShownBy: _isDescending),
  GridCardView(selectedSortBy: _selectedSortBy, selectedShownBy: _isDescending),
];

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DropdownButton<String>(
                    hint: Text(_selectedSortBy),
                    items: <String>['name', 'category', 'created_at']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (selected) {
                      setState(() {
                        _selectedSortBy = selected;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    hint: Text(_selectedShownBy),
                    items:
                        <String>['descending', 'ascending'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (selected) {
                      setState(() {
                        _isDescending = !_isDescending;
                        _selectedShownBy = selected;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.list,
                    ),
                    onPressed: () {
                      setState(() {
                        _widgetIndex = 0;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.grid_on,
                    ),
                    onPressed: () {
                      setState(() {
                        _widgetIndex = 1;
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        _displayWidget.elementAt(_widgetIndex),
      ],
    );
  }
}
