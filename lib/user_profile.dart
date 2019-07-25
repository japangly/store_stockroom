import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'env.dart';
import 'themes/helpers/buttons.dart';
import 'themes/helpers/fonts.dart';
import 'themes/helpers/theme_colors.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text('Profile'),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
              child: Center(
                child: Container(
                  width: Environment().getHeight(height: 10),
                  height: Environment().getHeight(height: 10),
                  child: CircleAvatar(
                    minRadius: Environment().getHeight(height: 3),
                    maxRadius: Environment().getHeight(height: 3),
                    backgroundImage: NetworkImage(
                      'https://media.femalemag.com.sg/2019/03/51021013_237686723851021_5419594866899599564_n-750x938.jpg',
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Liza Blink',
                  style: font20Black,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Stock Manager',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: ListTile.divideTiles(context: context, tiles: [
                  ListTile(
                    title: Text(
                      'Phone Number',
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomButton(
                      colorButton: blueColor,
                      onPressed: () {},
                      textButton: 'Logout',
                    ),
                  ),
                ]).toList(),
              ),
            ),
          ],
        ));
  }
}
