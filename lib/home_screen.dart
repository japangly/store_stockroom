import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'package:page_transition/page_transition.dart';

import 'add_product.dart';
import 'history.dart';
import 'inventory_screen.dart';
import 'product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

int _selectedIndex = 0;
List<Widget> _widgetOptions = <Widget>[
  InventoryScreen(),
  Center(
    child: Text('Coming Soon Brader... :)'),
  ),
  HistoryScreen(),
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
                PageTransition(
                    child: ProductDetails(),
                    type: PageTransitionType.rightToLeftWithFade),
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
      body: _widgetOptions.elementAt(_selectedIndex),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                child: AddProduct(),
                type: PageTransitionType.downToUp,
              ));
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
