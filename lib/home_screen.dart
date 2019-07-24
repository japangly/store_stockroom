import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'package:store_stockroom/Function/authentication.dart';

import 'Function/check_internet_connection.dart';
import 'custom_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

int _swapIndex = 0;
List<Widget> _swapWidget = <Widget>[
  Text('List 1'),
  Text('Grid 2'),
];
int _selectedIndex = 0;
List<Widget> _widgetOptions = <Widget>[
  CardGridView(),
  Text('Screen 2'),
  Text('Screen 3'),
];
List<String> _names = [
  'Igor Minar',
  'Brad Green',
  'Dave Geddes',
  'Naomi Black',
  'Greg Weber',
  'Dean Sofer',
  'Wes Alvaro',
  'John Scott',
  'Daniel Nadasi',
];

class _HomeScreenState extends State<HomeScreen> {
  String name = 'No one';

  final _formKey = new GlobalKey<FormState>();

  _buildMaterialSearchPage(BuildContext context) {
    return MaterialPageRoute<String>(
        settings: RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return Material(
            child: MaterialSearch<String>(
              placeholder: 'Search',
              results: _names
                  .map((String v) => MaterialSearchResult<String>(
                        icon: Icons.person,
                        value: v,
                        text: "Mr(s). $v",
                      ))
                  .toList(),
              filter: (dynamic value, String criteria) {
                return value.toLowerCase().trim().contains(
                    new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              onSelect: (dynamic value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SearchDetail(),
                ),
              ),
              onSubmit: (String value) => Navigator.of(context).pop(value),
            ),
          );
        });
  }

  _showMaterialSearch(BuildContext context) {
    Navigator.of(context)
        .push(_buildMaterialSearchPage(context))
        .then((dynamic value) {
      setState(() => name = value as String);
    });
  }

  void _onTappedView(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text('store_stockroom'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              _showMaterialSearch(context);
            },
          )
        ],
      ),
      body: Column(
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
                      _swapIndex = 0;
                    });
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.dashboard),
                  onPressed: () {
                    setState(() {
                      _swapIndex = 1;
                    });
                  },
                ),
              ),
            ],
          ),
          Container(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Inventory'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spellcheck),
            title: Text('To-Confirm'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text('History'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTappedView,
      ),
    );
  }
}

String _selectedSort = 'Name';
String _selectedLetter = 'Lower';

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
        items: <String>['Upper', 'Lower'].map((String value) {
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
        items: <String>['name', 'create_at'].map((String value) {
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

class SearchDetail extends StatefulWidget {
  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  int _selectIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_names.elementAt(_selectIndex)),
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
    return _swapWidget.elementAt(_swapIndex);
  }
}
