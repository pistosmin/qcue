import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'category.dart';
import 'add.dart';
import 'search.dart';
import 'detail.dart';
import 'createQuestList.dart';
import 'record.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];
  List<int> _myList = new List();

  ScrollController scrollController;
  TabController _tabController;

  DateTime currentBackPressTime = DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "한번 더 누르면 종료됩니다.");
      return Future.value(false);
    }
    return Future.value(true);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    scrollController = new ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;
  final List<Widget> _children = [];

  Widget _buildBody(BuildContext context, String uid) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ongoing_quests')
          .where('participant',
              arrayContains: uid) // 이부분으로써 uid가 participant에 있는지를 확인 할 수 있다.
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return Container(
          child: GridView.count(
            crossAxisCount: 1,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 15.0 / 11.0,
            children: _buildGridCards(context, snapshot.data.documents, uid),
          ),
        );
      },
    );
  }

  Widget _buildProgressBody(BuildContext context, String uid) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ongoing_quests')
          .where('participant',
              arrayContains: uid) // 이부분으로써 uid가 participant에 있는지를 확인 할 수 있다.
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return Container(
          child: GridView.count(
            crossAxisCount: 1,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 15.0 / 11.0,
            children: _buildGridCards(context, snapshot.data.documents, uid),
          ),
        );
      },
    );
  }

  Widget _buildDoneBody(BuildContext context, String uid) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ongoing_quests')
          .where('isClear', isEqualTo: 'true')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return Container(
          child: GridView.count(
            crossAxisCount: 1,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 15.0 / 11.0,
            children: _buildGridCards(context, snapshot.data.documents, uid),
          ),
        );
      },
    );
  }

  List<Card> _buildGridCards(
      BuildContext context, List<DocumentSnapshot> documents, String uid) {
    if (documents == null || documents.isEmpty) {
      return const [];
    }
    return documents.map((ongoing_quests) {
      final record = Record.fromSnapshot(ongoing_quests);
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.all(
            //     8.0,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text(
            //         record.name,
            //         style:
            //             TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            //       ),
            //       Text(
            //         record.writer,
            //         style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
            //       )
            //     ],
            //   ),
            // ),
            Image.network(
              record.image,
              width: double.infinity,
              height: 130.0,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.all(
                8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    record.name,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    record.explanation,
                    style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
                  ),
                  Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      documentid: record.reference.documentID,
                                    ),
                              ));
                        },
                        child: new Text('MORE',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15.0, fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _mainBodyBuilder(context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.currentUser().asStream(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DefaultTabController(
              length: 3,
              initialIndex: 1,
              child: Column(
                children: <Widget>[
                  TabBar(
                    indicatorWeight: 2.0,
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Colors.orange[800],
                    tabs: <Widget>[
                      Tab(
                        text: '전체',
                      ),
                      Tab(
                        text: '진행중인 퀘스트',
                      ),
                      Tab(
                        text: '완료한 퀘스트',
                      )
                    ],
                  ),
                  Container(
                    height: 650.0,
                    child: TabBarView(
                      children: <Widget>[
                        Center(
                          child: _buildBody(context, snapshot.data.uid),
                        ),
                        Center(
                          child: _buildProgressBody(context, snapshot.data.uid),
                        ),
                        Center(
                          child: _buildDoneBody(context, snapshot.data.uid),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      // onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("QCUE", style: TextStyle(color: Colors.orange[800]),),
          iconTheme: new IconThemeData(color: Colors.orange[800]),
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                // color: Colors.white,
                color: Colors.orange[800],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateQuestListPage(),
                  ),
                );
              },
            ),
          ],
          // backgroundColor: Colors.white,
                  backgroundColor: Colors.orange[50],

        ),
        body: _mainBodyBuilder(context),
        backgroundColor: Colors.orange[50],
                  // backgroundColor: Colors.white,

        drawer: CustomDrawer(),
        // bottomNavigationBar: ,
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.photo, this.onTap, this.width, this.height})
      : super(key: key);
  final String photo;
  final VoidCallback onTap;
  final double width;
  final double height;
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
