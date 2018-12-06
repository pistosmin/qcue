import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'questList.dart';
import 'add.dart';
import 'gridcategory.dart';

class CustomDrawer extends StatefulWidget {
  @override
  createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.currentUser().asStream(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          return Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the Drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                DrawerHeader(
                  child: InkWell(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 0.0, left: 10.0),
                      // margin: const EdgeInsets.only(top: 50.0, bottom: 20.0, left: 0.0),
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 60.0, height: 60.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data.photoUrl),
                                  fit: BoxFit.cover),
                            ),
                            margin:
                                const EdgeInsets.only(right: 10.0, left: 0.0),
                            // padding:const EdgeInsets.only(left: 0.0) ,
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '안녕하세요! \n' + snapshot.data.displayName + '님',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'NanumSquare'),
                                ),
                                Text(
                                  snapshot.data.email,
                                  style: TextStyle(
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
                      Navigator.pushNamed(context, "/mypage");
                    },
                  ),
                ),
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
                    leading: Icon(Icons.list),
                    title: new Text("Quest List"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuestListPage()),
                      );
                    }),
                    new ListTile(
                    dense: true,
                    leading: Icon(Icons.add_to_photos),
                    title: new Text("Add Quest List"),
                    onTap: () {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GridCateogory()),
                      );
                    }),
              ],
            ),
          );
        });
  }
}
