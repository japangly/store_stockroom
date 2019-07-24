import 'package:flutter/material.dart';

class CardListView extends StatefulWidget {
  @override
  _CardListViewState createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Text(
                'Item Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Create At'),
                    Text('Category'),
                    Text('In Stock'),
                    Text('In Service'),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
