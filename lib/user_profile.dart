import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_stockroom/change_password.dart';
import 'package:store_stockroom/database.dart';

import 'env.dart';
import 'functions/auth.dart';
import 'log_in_screen.dart';
import 'themes/helpers/fonts.dart';
import 'themes/helpers/theme_colors.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  SharedPreferences sharedPreferences;
  String token;
  bool _loadingState = false;

  @override
  void initState() {
    super.initState();
    _getSharePreference();
  }

  Future _getSharePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
  }

  Future _signOut(BuildContext context) async {
    setState(() {
      _loadingState = true;
    });
    sharedPreferences.clear();
    await Authentication().signOut().whenComplete(() {
      setState(() {
        _loadingState = false;
      });
    }).whenComplete(() {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ChangePasswordScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: ModalProgressHUD(
        child: FutureBuilder<QuerySnapshot>(
          future: Database().getCurrentUserInfo(),
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView(children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 15.0),
                          child: Center(
                            child: Container(
                              width: Environment().getHeight(height: 8),
                              height: Environment().getHeight(height: 8),
                              child: CircleAvatar(
                                minRadius: Environment().getHeight(height: 3),
                                maxRadius: Environment().getHeight(height: 3),
                                backgroundImage: NetworkImage(
                                  snapshot.data.documents.first['image'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              ReCase(
                                snapshot.data.documents.first['first_name'] +
                                    ' ' +
                                    snapshot.data.documents.first['last_name'],
                              ).titleCase,
                              style: font20Black,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ReCase(snapshot.data.documents.first['role'])
                                    .titleCase,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          title: Text(
                            ReCase('phone number').titleCase,
                            style: font15Grey,
                          ),
                          trailing: Text(
                            snapshot.data.documents.first['phone_number'],
                            style: font15Black,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            ReCase('email').titleCase,
                            style: font15Grey,
                          ),
                          trailing: Text(
                            snapshot.data.documents.first['email']
                                .toString()
                                .toLowerCase(),
                            style: font15Black,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            ReCase('birthday').titleCase,
                            style: font15Grey,
                          ),
                          trailing: Text(
                            ReCase(
                              DateFormat('d MMMM y')
                                  .format(
                                    snapshot
                                        .data.documents.first['date_of_birth']
                                        .toDate(),
                                  )
                                  .toString(),
                            ).titleCase,
                            style: font15Black,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            ReCase('place of birth').titleCase,
                            style: font15Grey,
                          ),
                          trailing: Text(
                            ReCase(snapshot
                                    .data.documents.first['place_of_birth'])
                                .titleCase,
                            style: font15Black,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            ReCase('address').titleCase,
                            style: font15Grey,
                          ),
                          trailing: Text(
                            ReCase(snapshot.data.documents.first['address'])
                                .titleCase,
                            style: font15Black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  )),
                                  textColor: Colors.white,
                                  color: Colors.blue,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    ReCase('sign out').titleCase,
                                  ),
                                  onPressed: () async {
                                    await _signOut(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ],
            );
          },
        ),
        inAsyncCall: _loadingState,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }
}
