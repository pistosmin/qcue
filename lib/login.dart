import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/scheduler.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Future<String> _message = Future<String>.value('');
  String verificationId;

  void _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.4;
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 220.0),
            Container(
              // padding: EdgeInsets.only(top: 100.0, bottom: 70.0),
              alignment: Alignment.center,
              child: Hero(
                tag: 'tick',
                child: new Image.asset('assets/qcue.png',
                    width: 130.0, height: 130.0, scale: 1.0),
              ),
              // Image.asset(
              //   'assets/qcue.png',
              //   height: 100.0,
              //   width: 100.0,
              //   alignment: Alignment.center,
              // ),
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "퀘",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "스트 ",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "큐",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "레이션 ",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "서비스",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 180.0),
            RaisedButton(
                splashColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.red,
                child: Row(
                  children: <Widget>[
                    // Container(
                    //   child: new Image.asset(
                    //     'assets/google.png',
                    //     width: 33.0,
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.only(left: 5.0),
                      alignment: Alignment.centerLeft,
                      child: new Text(
                        'G+',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      // padding: EdgeInsets.only(left: 10.0),
                      alignment: Alignment.center,
                      child: new Text(
                        'Google 아이디로 QCUE를 시작!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _signInWithGoogle();
                  });
                }),
          ],
        ),
      )),
    );
  }
}
