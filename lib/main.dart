import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';

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
      },
    );
  }
}
