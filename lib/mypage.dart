import 'package:flutter/material.dart';
import 'package:timeline/model/timeline_model.dart';
import 'package:timeline/timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'drawer.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key key}) : super(key: key);
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  String _imageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjhJ_fE8brBZTj3ZXyqbs00etqFS7shBubvpVai0p0NkY7fHaZ-g';
  final List<TimelineModel> list = [
    TimelineModel(id: "1", description: "Test 1", title: "Test 1"),
    TimelineModel(id: "2", description: "Test 2", title: "Test 2")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('My Profile', style: TextStyle(color: Colors.orange[800]),),
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              semanticLabel: 'back',
              color: Colors.orange[800],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // title: Text('My Page'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.orange[800],
              ),
              onPressed: () async {
                // await FirebaseAuth.instance.signOut();
                //검사용:
                await _googleSignIn.signOut();
                // await FBApi.signOut();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
          backgroundColor: Colors.orange[50],
        ),
        backgroundColor: Colors.orange[50],
        body: StreamBuilder(
            stream: FirebaseAuth.instance.currentUser().asStream(),
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {

              if (snapshot.data.isAnonymous) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('You are Guest'),
                    Text('uid: ${snapshot.data.uid}'),
                  ],
                );
              } else {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // background image and bottom contents
                    Column(
                      children: <Widget>[
                        Container(
                          height: 200.0,
                          color: Colors.orange,
                          child: Center(
                            child: Image.asset('assets/profilebackground.jpeg',fit: BoxFit.fill,width: double.infinity,),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top:100.0),
                            // color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Text(snapshot.data.displayName),
                                Text(snapshot.data.email),
                                // Text(snapshot.data.phoneNumber)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    // Profile image
                    Positioned(
                      top:
                          150.0, // (background container size) - (circle height / 2)
                      child: new ClipRRect(
                        borderRadius: new BorderRadius.circular(100.0),
                        child: Image.network(snapshot.data.photoUrl, height: 95.0, width: 95.0,),
                      ),

                    )
                  ],
                );
              }
            }));
  }
}

