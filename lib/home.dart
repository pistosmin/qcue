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
   Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ongoing_quests')
          .document()
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return Container(
          child: GridView.count(
            crossAxisCount: 1,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 7.0 / 3.0,
            children: _buildGridCards(context, snapshot.data.documents),
          ),
        );
      },
    );
  }

  // Widget _buildBody(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: Firestore.instance
  //         .collection('ongoing_quests')
  //         .where('isClear', isEqualTo: 'false')
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

  Widget _buildDoneBody(BuildContext context) {
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
            childAspectRatio: 7.0 / 3.0,
            children: _buildGridCards(context, snapshot.data.documents),
          ),
        );
      },
    );
  }

  List<Card> _buildGridCards(
      BuildContext context, List<DocumentSnapshot> documents) {
    if (documents == null || documents.isEmpty) {
      return const [];
    }
    return documents.map((ongoing_quests) {
      final record = Record.fromSnapshot(ongoing_quests);
      // ongoing_quests.documentID
      return Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 10 / 9,
              child: new Image.network(
                record.image,
                height: 100.0,
                width: 100.0,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(record.name,
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold)),
                  Text(record.writer,
                      style: TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.bold)),
                  Text(record.explanation, style: TextStyle(fontSize: 13.0)),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Icon(Icons.favorite),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Icon(Icons.file_download),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Icon(Icons.mode_comment),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Text(
                            record.favo.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            record.down.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            record.comment.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  new FlatButton(
                    onPressed: () {
                      print(record.name);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                                name: record.name,
                              ),
                        ),
                      );
                    },
                    textColor: Colors.blue,
                    padding: const EdgeInsets.only(left: 100.0),
                    child: new Text(
                      "more",
                    ),
                  ),
                ],
              ),
            )),
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
                            new Text('현재')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 500.0,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildBody(context)),
                      );
                    },
                  ),
                ),
                // DefaultTabController(
                //   length: 3,
                //   initialIndex: 0,
                //   child: Column(
                //     children: <Widget>[
                //       TabBar(
                //         indicatorColor: Theme.of(context).primaryColor,
                //         labelColor: Colors.black,
                //         tabs: <Widget>[
                //           Tab(
                //             text: '진행중인 퀘스트',
                //           ),
                //           Tab(
                //             text: '완료한 퀘스트',
                //           ),
                //           Tab(
                //             text: '알림',
                //           )
                //         ],
                //       ),
                //       Container(
                //         height: 600.0,
                //         child: TabBarView(
                //           children: <Widget>[
                //             Center(
                //               child: _buildBody(context),
                //             ),
                //             Center(
                //               child: _buildDoneBody(context),
                //             ),
                //             Center(
                //               child: Text('알림은 여기'),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
        uid = reference.documentID,
        name = map['name'],
        writer = map['writer'],
        explanation = map['explanation'],
        image = map['image'],
        favo = map['favo'],
        down = map['down'],
        comment = map['comment'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$writer>";
}
