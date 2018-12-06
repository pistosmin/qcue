import 'package:flutter/material.dart';

import 'login.dart';
import 'home.dart';
import 'search.dart';
import 'createQuestList.dart';
import 'createQuest.dart';
import 'viewQuestList.dart';
import 'viewQuest.dart';
import 'mypage.dart';
import 'package:project_qcue/splash/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color color = Colors.orange[700];
  var routes = <String, WidgetBuilder>{
    '/login': (BuildContext context) => LoginPage(),
    '/home': (BuildContext context) => HomePage(),
    '/search': (BuildContext context) => SearchPage(),
    '/createQuestList': (BuildContext context) => CreateQuestListPage(),
    '/createQuest': (BuildContext context) => CreateQuestPage(),
    '/viewQuestList': (BuildContext context) => ViewQuestList(),
    '/viewQuest': (BuildContext context) => ViewQuest(),
    '/mypage': (BuildContext context) => MyPage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Firebase Auth Demo',
      title: "TODO Qration app",
      debugShowCheckedModeBanner: false,
      home: new Container(child: new Splash()),
      theme: ThemeData(
          primaryColor: color,
          // primarySwatch: Colors.grey,
          accentColor: color,
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white))),
      // initialRoute: '/login',
      routes: routes,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (_) => LoginPage(),
              settings: settings,
            );
        }
      },
    );
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }
    return new FadeTransition(opacity: animation, child: child);
  }
}