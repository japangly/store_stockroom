import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_search/material_search.dart';
import 'package:page_transition/page_transition.dart';

import 'add_product.dart';
import 'history.dart';
import 'inventory_screen.dart';
import 'product_details.dart';
import 'user_profile.dart';

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
  File imageFile;
  String name = 'No one';

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
                return value
                    .toLowerCase()
                    .trim()
                    .contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return UserProfile();
                  },
                ),
              );
            },
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
        floatingActionButton: _bottomButtons());
  }

  Widget _bottomButtons() {
    switch (_selectedIndex) {
      case 0:
        return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await ImagePicker.pickImage(source: ImageSource.camera).then(
              (file) async {
                imageFile = await ImageCropper.cropImage(
                  sourcePath: file.path,
                  toolbarTitle: 'Edit Image',
                  toolbarColor: Colors.blue,
                  toolbarWidgetColor: Colors.white,
                  ratioX: 1.0,
                  ratioY: 1.0,
                  maxWidth: 512,
                  maxHeight: 512,
                );
              },
            ).whenComplete(
              () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: AddProduct(),
                    type: PageTransitionType.downToUp,
                  ),
                );
              },
            );
          },
        );
        break;
      case 2:
        return FloatingActionButton(
          child: Icon(Icons.print),
          onPressed: () {},
        );
        break;
    }
  }
}

class SearchDetails extends StatefulWidget {
  @override
  _SearchDetailsState createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
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
