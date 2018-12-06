import 'package:flutter/material.dart';
import 'home.dart';
import 'add.dart';
import 'gridcategory.dart';

class DropMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DropMenuState();
  }
}

class DropMenuState extends State<DropMenu> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          DrawerHeader(child: Text('data'),),
          new ListTile(
              dense: true,
              leading: Icon(Icons.home),
              title: new Text("Home"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }),
          new ListTile(
              dense: true,
              leading: Icon(Icons.add_to_photos),
              title: new Text("Add questlist"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPage()),
                );
              }),
              new ListTile(
              dense: true,
              leading: Icon(Icons.apps),
              title: new Text("Category"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GridCateogory()),
                );
              }),
        ],
      ),
    );
  }
}
