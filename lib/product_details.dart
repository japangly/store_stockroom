import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/octicons.dart';
import 'package:store_stockroom/dialogs/delete_dialog.dart';
import 'package:store_stockroom/dialogs/edit_dialog.dart';
import 'package:store_stockroom/themes/helpers/theme_colors.dart';
import 'env.dart';
import 'themes/helpers/fonts.dart' as ft;
import 'themes/helpers/theme_colors.dart';

class ProductDetails extends StatelessWidget {
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFZ1T_DlCjC2KZNwXCJc80wIsWoSJDWDr3bGInOsuVMhDelJKC',
                    height: Environment().getHeight(height: 7.0),
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size(0.0, Environment().getHeight(height: 8.0)),
        ),
        title: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Product Details',
                style: ft.font20White,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              child: Text(
                'Sunsilk Hair Fall Control',
                style: TextStyle(
                    fontSize: 20.0,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 10.0),
              child: Text(
                'Shampoo',
                style: ft.font15Grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Octicons.getIconData("primitive-dot"),
                        color: Colors.green[300],
                      ),
                      Text(
                        'In Stock: 300',
                        style: TextStyle(
                          color: Colors.green[300],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Octicons.getIconData("primitive-dot"),
                        color: Colors.orange[300],
                      ),
                      Text(
                        'In Use: 10',
                        style: TextStyle(
                          color: Colors.orange[300],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
                child: Divider(
                  color: Colors.black,
                  height: 10,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              child: Text(
                'Description',
                style: ft.font20Black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text(
                  'Whipped Crème & Honey™ Volumizing Shampoo strengthens hair as it works to pump up each individual strand, adding body and bounce. It’s an ideal shampoo for finer hair textures. Lather this volumizing shampoo into hair daily and rinse thoroughly. Leaves hair as sweet as can be.\nFollow with any SUDZZfx® conditioner.adds volume & body – great for fine hair\npH 4.5 – 5.5'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Created at: 20/03/2019',
                        style: TextStyle(color: blueColor),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Updated at: 20/09/2019',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: removeColor,
                child: new Text("Delete"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return DeleteDialog();
                      });
                },
              ),
            ),
            Expanded(
              flex: 70,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Edit",
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return EditDialog();
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
