import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Firebase Auth Demo',
      home: LoginPage(),
      initialRoute: 'login',
      routes: {
        'login':(context) => LoginPage(),
        'home':(context) => HomePage(),
        'search':(context) => HomePage(),
      },
    );
  }
}
