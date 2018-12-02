import 'package:flutter/material.dart';

import 'login.dart';
import 'home.dart';
import 'search.dart';
import 'createQuestList.dart';
import 'createQuest.dart';
import 'viewQuestList.dart';
import 'viewQuest.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Firebase Auth Demo',
      home: LoginPage(),
      theme: ThemeData(
        primaryColor: Colors.orange[800],
        accentColor: Colors.orange[800],
      ),
      initialRoute: 'login',
      routes: {
        'login':(context) => LoginPage(),
        'home':(context) => HomePage(),
        'search':(context) => HomePage(),
        '/createQuestList': (context) => CreateQuestListPage(),
        '/createQuest': (context) => CreateQuestPage(),
        '/viewQuestList': (context) => ViewQuestList(),
        '/viewQuest': (context) => ViewQuest(),
      },
    );
  }
}
