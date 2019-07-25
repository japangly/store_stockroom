import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/octicons.dart';
import 'package:store_stockroom/dialogs/delete_dialog.dart';
import 'package:store_stockroom/dialogs/edit_dialog.dart';
import 'package:store_stockroom/themes/helpers/theme_colors.dart';
import 'package:store_stockroom/themes/helpers/theme_colors.dart' as prefix0;
import 'env.dart';
import 'themes/helpers/fonts.dart' as ft;
import 'themes/helpers/theme_colors.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
            Center(
              child: Container(
                decoration:
                    new BoxDecoration(color: prefix0.whiteColor, boxShadow: [
                  new BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                  ),
                ]),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://www.natio.com.au/pub/media/catalog/product/cache/e4d64343b1bc593f1c5348fe05efa4a6/h/a/haircare_2019_product_web_images_dc_shampoo.jpg',
                    height: Environment().getHeight(height: 10.0),
                  ),
                ),
              ),
            ),
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
                        color: Colors.green[500],
                      ),
                      Text(
                        'In Stock: 500',
                        style: TextStyle(
                          color: Colors.green[500],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Octicons.getIconData("primitive-dot"),
                        color: Colors.orange[500],
                      ),
                      Text(
                        'In Use: 10',
                        style: TextStyle(
                          color: Colors.orange[500],
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
                        style: TextStyle(color: Colors.blue[500]),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Updated at: 20/09/2019',
                        style: TextStyle(color: Colors.green[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            flex: 30,
            child: RaisedButton(
              padding: const EdgeInsets.all(15.0),
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
              padding: const EdgeInsets.all(15.0),
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
    );
  }
}
