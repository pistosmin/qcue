import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'category.dart';
import 'add.dart';
import 'search.dart';
import 'detail.dart';
import 'createQuestList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];
  List<int> _myList = new List();

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  TabController _tabController;

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

//firebase ongoing_quest에서 user에 저장된 document내용만 들고오기
  //  Widget _buildBody(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: Firestore.instance
  //         .collection('ongoing_quests')
  //         .document()
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) return LinearProgressIndicator();
  //       return Container(
  //         child: GridView.count(
  //           crossAxisCount: 1,
  //           padding: EdgeInsets.all(16.0),
  //           childAspectRatio: 7.0 / 3.0,
  //           children: _buildGridCards(context, snapshot.data.documents),
  //         ),
  //       );
  //     },
  //   );
  // }

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
      // print('document :'+ongoing_quests.data.toString());
      final record = Record.fromSnapshot(ongoing_quests);
      // print(record.participant.contains('JGua38JkfYTbF7cFK6Q7cvXyIMw2'));
      // ongoing_quests.documentID
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // AspectRatio(
            //   aspectRatio: 15 / 5,
            //   child: PhotoHero(
            //     photo: record.image,
            //     width: double.infinity,
            //     // height: 130.0,
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => DetailPage(
            //                 documentid: record.reference.documentID,
            //               ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
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
                    record.writer,
                    style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
                  )
                ],
              ),
            ),
            // PhotoHero(
            //     photo: record.image,
            //     width: double.infinity,
            //     height: 130.0,
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => DetailPage(
            //                 documentid: record.reference.documentID,
            //                 image: record.image,
            //               ),
            //         ),
            //       );
            //     },
            //   ),
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
                    record.explanation,
                    style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
                  ),
                  RaisedButton(
                    onPressed: () {
                      // print(record.uid);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  // documentid: record.reference.documentID,
                                  userID: uid,
                                  documentID: record.uid,
                                  name: record.name,
                                  writer: record.writer,
                                  image: record.image,
                                  explanation: record.explanation,
                                ),
                          ));
                    },
                    child: new Text('more'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qcue"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.add,
              color: Colors.white,
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
          // backgroundColor: Colors.orange[800],
          IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new SearchPage()),
              );
            },
          )
        ],
        backgroundColor: Colors.orange[800],
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.currentUser().asStream(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.data.isAnonymous) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('You are Guest'),
                StreamBuilder(
                  stream: FirebaseAuth.instance.currentUser().asStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<FirebaseUser> snapshot) {
                    return Text('uid: ${snapshot.data.uid}');
                  },
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.all(20.0),
                  child: new Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(snapshot.data.photoUrl),
                            )),
                      ),
                      new Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '안녕하세요! ' + snapshot.data.displayName + '님',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            new Text('계획없는 목표는 한낱 꿈에 불과하다.')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        indicatorColor: Theme.of(context).primaryColor,
                        labelColor: Colors.black,
                        tabs: <Widget>[
                          Tab(
                            text: '진행중인 퀘스트',
                          ),
                          Tab(
                            text: '완료한 퀘스트',
                          ),
                          Tab(
                            text: '알림',
                          )
                        ],
                      ),
                      Container(
                        height: 500.0,
                        child: TabBarView(
                          children: <Widget>[
                            Center(
                              child: _buildBody(context, snapshot.data.uid),
                            ),
                            Center(
                              child: _buildDoneBody(context, snapshot.data.uid),
                            ),
                            Center(
                              child: Text('알림은 여기'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class Record {
  final String name;
  final String image;
  final String writer;
  final String explanation;
  final String uid;
  List<dynamic> participant;
  final int favo;
  final int down;
  final int comment;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['writer'] != null),
        assert(map['explanation'] != null),
        assert(map['image'] != null),
        assert(map['favo'] != null),
        assert(map['down'] != null),
        assert(map['comment'] != null),
        assert(map['participant'] != null),
        uid = reference.documentID,
        name = map['name'],
        writer = map['writer'],
        explanation = map['explanation'],
        image = map['image'],
        favo = map['favo'],
        down = map['down'],
        comment = map['comment'],
        participant = map['participant'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$writer>";
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
