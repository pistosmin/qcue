import 'package:flutter/material.dart';

//firebase packages
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'drawer.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key key}) : super(key: key);
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  String _imageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjhJ_fE8brBZTj3ZXyqbs00etqFS7shBubvpVai0p0NkY7fHaZ-g';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Page",
            style: TextStyle(color: Colors.orange[800]),
          ),
          iconTheme: new IconThemeData(color: Colors.orange[800]),
          elevation: 0.3,
          centerTitle: true,
          backgroundColor: Colors.orange[50],
        ),
        drawer: CustomDrawer(),
        backgroundColor: Colors.orange[50],
        body: StreamBuilder(
            stream: FirebaseAuth.instance.currentUser().asStream(),
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 0.0, left: 10.0),
                      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 60.0, height: 60.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image:  DecorationImage(
                                  image: 
                                  snapshot.data.photoUrl == null 
                                  ? Image.network(_imageUrl) 
                                  : NetworkImage(snapshot.data.photoUrl),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          )
        );
  }
}
