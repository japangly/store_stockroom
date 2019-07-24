import 'package:flutter/material.dart';
import 'package:store_stockroom/custom_list_view.dart';

import 'custom_grid_view.dart';

int _swapIndex = 0;
List<Widget> _swapWidget = <Widget>[
  CardGridView(),
  CardListView(),
];

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              CheckNameCreateAt(),
              Expanded(
                child: Container(),
              ),
              CheckUpperLower(),
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {
                    setState(() {
                      _swapIndex = 1;
                    });
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.dashboard),
                  onPressed: () {
                    setState(() {
                      _swapIndex = 0;
                    });
                  },
                ),
              ),
            ],
          ),
          _swapWidget.elementAt(_swapIndex),
        ],
      ),
    );
  }
}

String _selectedSort = 'Name';
String _selectedLetter = 'Desc';

class CheckUpperLower extends StatefulWidget {
  const CheckUpperLower({
    Key key,
  }) : super(key: key);

  @override
  _CheckUpperLowerState createState() => _CheckUpperLowerState();
}

class _CheckUpperLowerState extends State<CheckUpperLower> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: DropdownButton<String>(
        hint: Text(_selectedLetter),
        items: <String>['Desc', 'Indesc'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (selected) {
          setState(() {
            _selectedLetter = selected;
          });
        },
      ),
    );
  }
}

class CheckNameCreateAt extends StatefulWidget {
  const CheckNameCreateAt({
    Key key,
  }) : super(key: key);

  @override
  _CheckNameCreateAtState createState() => _CheckNameCreateAtState();
}

class _CheckNameCreateAtState extends State<CheckNameCreateAt> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: DropdownButton<String>(
        hint: Text(_selectedSort),
        items: <String>['Name', 'Create_at'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (selected) {
          setState(() {
            _selectedSort = selected;
          });
        },
      ),
    );
  }
}

class SwapWidget extends StatefulWidget {
  @override
  _SwapWidgetState createState() => _SwapWidgetState();
}

class _SwapWidgetState extends State<SwapWidget> {
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
