import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'env.dart';
import 'themes/helpers/buttons.dart';
import 'themes/helpers/fonts.dart';
import 'themes/helpers/theme_colors.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(80.0, 0.0, 80.0, 20.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: Environment().getHeight(height: 3),
                      backgroundImage: NetworkImage(
                        'https://img.kpopmap.com/2019/01/700b9aabb84c4b531a3c058a168eefbf.jpg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Liza Blink',
                            style: font25White,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Stock Manager',
                            style:
                                TextStyle(fontSize: 12.0, color: whiteColor)),
                      ],
                    ),
                  ],
                ),
              ),
              preferredSize: Size(0.0, Environment().getHeight(height: 9.8)),
            ),
            title: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text('Profile'),
                ),
              ],
            ),
            leading: Icon(
              Icons.arrow_back_ios,
              size: 20.0,
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: ListTile.divideTiles(context: context, tiles: [
                    ListTile(
                      title: Text(
                        'Mobile',
                        style: font15Grey,
                      ),
                      trailing: Text('098 837 493', style: font15Black),
                    ),
                    ListTile(
                      title: Text(
                        'Email',
                        style: font15Grey,
                      ),
                      trailing:
                          Text('lisainthehouse@gmail.com', style: font15Black),
                    ),
                    ListTile(
                      title: Text(
                        'Birthday',
                        style: font15Grey,
                      ),
                      trailing: Text('09/March/1998', style: font15Black),
                    ),
                    ListTile(
                      title: Text(
                        'Place of Birth',
                        style: font15Grey,
                      ),
                      trailing: Text('Phnom Penh', style: font15Black),
                    ),
                    ListTile(
                      title: Text(
                        'Address',
                        style: font15Grey,
                      ),
                      trailing: Text('Phnom Penh', style: font15Black),
                    ),
                  ]).toList(),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: CustomButton(
                    colorButton: blueColor,
                    onPressed: () {},
                    textButton: 'Logout',
                  ))
            ],
          )),
    );
  }
}
