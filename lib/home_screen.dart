import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import 'create_product.dart';
import 'custom_library/search_library.dart';
import 'dashboard_screen.dart';
import 'database.dart';
import 'history_screen.dart';
import 'print.dart';
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
  DashboardScreen(),
  Center(
    child: Text('Coming Soon!'),
  ),
  HistoryScreen(),
];
List<String> _names = [];
List<DocumentSnapshot> documents;

class _HomeScreenState extends State<HomeScreen> {
  String name = 'No one';

  _buildMaterialSearchPage(BuildContext context) {
    return MaterialPageRoute<String>(
        settings: RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return StreamBuilder<QuerySnapshot>(
              stream: Database().getProducts(
                collection: 'products',
                orderBy: 'name',
              ),
              builder: (context, snapshot) {
                return Material(
                  child: MaterialSearch<String>(
                    placeholder: 'Search',
                    results: documents
                        .map((DocumentSnapshot v) =>
                            MaterialSearchResult<String>(
                              // icon: Icons.person,
                              value: v,
                              text: v.data['name'],
                            ))
                        .toList(),
                    filter: (DocumentSnapshot value, String criteria) {
                      return value.data['name'].toLowerCase().trim().contains(
                          RegExp(r'' + criteria.toLowerCase().trim() + ''));
                    },
                    onSelect: (DocumentSnapshot value) => Navigator.push(
                          context,
                          PageTransition(
                              child: ProductDetails(
                                document: value,
                              ),
                              type: PageTransitionType.rightToLeftWithFade),
                        ),
                    onSubmit: (String value) =>
                        Navigator.of(context).pop(value),
                  ),
                );
              });
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

  dynamic _bottomButtons() {
    switch (_selectedIndex) {
      case 0:
        return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await ImagePicker.pickImage(source: ImageSource.camera).then(
              (imageFile) async {
                await ImageCropper.cropImage(
                  sourcePath: imageFile.path,
                  toolbarTitle: 'Edit Photo',
                  toolbarColor: Colors.blue,
                  toolbarWidgetColor: Colors.white,
                  ratioX: 1.0,
                  ratioY: 1.0,
                  maxWidth: 512,
                  maxHeight: 512,
                ).then((imageFile) {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: CreateProduct(
                        imageFile: imageFile,
                      ),
                      type: PageTransitionType.downToUp,
                    ),
                  );
                });
              },
            );
          },
        );
        break;
      case 2:
        return FloatingActionButton(
          child: Icon(Icons.print),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PrintScreen();
                },
              ),
            );
          },
        );
        break;
    }
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
              onPressed: () async {
                _names = [];
                try {
                  documents = await Database().getAllCollection(
                      collection: 'products', sortBy: 'name', order: true);
                  for (int i = 0; i < documents.length; i++) {
                    _names.add(documents[i].data['name']);
                  }
                  _showMaterialSearch(context);
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('Products'),
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
