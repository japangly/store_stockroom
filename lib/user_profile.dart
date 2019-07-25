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
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(80.0, 0.0, 80.0, 20.0),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: Environment().getHeight(height: 3),
                    backgroundImage: NetworkImage(
                      'https://media.femalemag.com.sg/2019/03/51021013_237686723851021_5419594866899599564_n-750x938.jpg',
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Stock Manager',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            preferredSize: Size(
              0.0,
              Environment().getHeight(
                height: 10.0,
              ),
            ),
          ),
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
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: ListView(
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
        ));
  }
}
