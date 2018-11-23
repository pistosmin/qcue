import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + user.uid);
    return user;
  }

  Future<FirebaseUser> _handleAnonSignIn() async {
    FirebaseUser user = await _auth.signInAnonymously();
    print("signed in " + user.uid);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 280.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
              ],
            ),
            SizedBox(height: 120.0),
            RaisedButton(
              child: Text(
                'Google',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              onPressed: () {
                _handleSignIn()
                    .then((FirebaseUser user) => Navigator.pop(context))
                    .catchError((e) => print(e));
              },
            ),
            SizedBox(height: 12.0),
            RaisedButton(
              child: Text('Guest', style: TextStyle(color: Colors.white)),
              color: Colors.grey,
              onPressed: () {
                _handleAnonSignIn()
                    .then((FirebaseUser user) => Navigator.pop(context))
                    .catchError((e) => print(e));
              },
            ),
          ],
        ),
      ),
    );
  }
}
