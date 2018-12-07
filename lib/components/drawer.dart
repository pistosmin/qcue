import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  createState() => new CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  var _name = '사용자님';
  var _email = "loading@email.com";
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: new ListView(
        // Important: Remove any padding from the ListView.
        padding: new EdgeInsets.all(0.0),
        children: <Widget>[
          new InkWell(
            child: new Container(

              padding: const EdgeInsets.only(bottom: 0.0, left: 10.0),
              margin: const EdgeInsets.only(top: 50.0, bottom: 20.0, left: 0.0),
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
              width: 60.0, height: 60.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        image: new AssetImage(
                          'assets/avatar.jpg',
                        ),
                        fit: BoxFit.cover
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 10.0, left: 0.0),
                    // padding:const EdgeInsets.only(left: 0.0) ,
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          _name,
                          style: new TextStyle(
                              fontSize: 30.0, fontFamily: 'NanumSquare'),
                        ),
                        new Text(
                          _email,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                              fontFamily: 'NanumSquare'),
                        )
                      ],
//
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),
          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            Icons.home,
                            size: 25.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                          )),
                      new Text(
                        'Home',
                        style:
                            new TextStyle(fontSize: 20.0, fontFamily: 'NanumSquare'),
                      ),
                    ],
                  ),
                  new Text(
                    '5',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/home");
            },
          ),
          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 15.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            Icons.date_range,
                            size: 25.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                          )),
                      new Text(
                        'Calendar',
                        style:
                            new TextStyle(fontSize: 20.0, fontFamily: 'NanumSquare'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/calender");
            },
          ),
          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 15.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            Icons.group_work,
                            size: 25.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                          )),
                      new Text(
                        'Groups',
                        style:
                            new TextStyle(fontSize: 20.0, fontFamily: 'NanumSquare'),
                      ),
                    ],
                  ),
                  new Text(
                    '5',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/group");
            },
          ),
          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 15.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            Icons.list,
                            size: 25.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                          )),
                      new Text(
                        'Lists',
                        style:
                            new TextStyle(fontSize: 20.0, fontFamily: 'NanumSquare'),
                      ),
                    ],
                  ),
                  new Text(
                    '18',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/list");
            },
          ),
          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 15.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            Icons.perm_identity,
                            size: 25.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                          )),
                      new Text(
                        'Profile',
                        style:
                            new TextStyle(fontSize: 20.0, fontFamily: 'NanumSquare'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),
          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 15.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            Icons.timeline,
                            size: 25.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                          )),
                      new Text(
                        'Timeline',
                        style:
                            new TextStyle(fontSize: 20.0, fontFamily: 'NanumSquare'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/timeline");
            },
          ),
          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 15.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            Icons.settings,
                            size: 25.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                          )),
                      new Text(
                        'Settings',
                        style:
                            new TextStyle(fontSize: 20.0, fontFamily: 'NanumSquare'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/setting");
            },
          ),
          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 15.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            Icons.exit_to_app,
                            size: 25.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                          )),
                      new Text(
                        'Log Out',
                        style:
                            new TextStyle(fontSize: 20.0, fontFamily: 'NanumSquare'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/login");
            },
          ),
        ],
      ),
    );
  }
}
