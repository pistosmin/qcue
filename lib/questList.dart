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
import 'dropMenu.dart';

class QuestListPage extends StatefulWidget {
  const QuestListPage({Key key}) : super(key: key);
  @override
  QuestListPageState createState() {
    return QuestListPageState();
  }
}

class QuestListPageState extends State<QuestListPage>
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
  Widget _buildBody(BuildContext context, String uid) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ongoing_quests')
          .where('participant',
              arrayContains: uid) // 이부분으로써 uid가 participant에 있는지를 확인 할 수 있다.
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return Center(
        child: OrientationBuilder(builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 8.0 / 9.0,
            children: _buildGridCards(context, snapshot.data.documents),
          );
        }),
      );
      },
    );
  }

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
            childAspectRatio: 15.0 / 11.0,
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
      // print('document :'+ongoing_quests.data.toString());
      final record = Record.fromSnapshot(ongoing_quests);
      // print(record.participant.contains('JGua38JkfYTbF7cFK6Q7cvXyIMw2'));
      // ongoing_quests.documentID
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
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
            // Image.network(
            //   record.image,
            //   width: double.infinity,
            //   height: 130.0,
            //   fit: BoxFit.fill,
            // ),
            Hero(
              tag: '${ongoing_quests.documentID}',
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: 
                  Image.network(
                    record.image,
                    width: double.infinity,
                    height: 60.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(
                8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    record.description,
                    style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
                  ),
                  FlatButton(
                    onPressed: () {
                      // print(record.uid);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  // documentid: record.reference.documentID,
                                  // userID: uid,
                                  documentID: record.uid,
                                  name: record.name,
                                  writer: record.writer,
                                  image: record.image,
                                  description: record.description,
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
        title: Text("My Quest List"),
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
      drawer: CustomDrawer(),
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
            return Center(
        child: _buildBody(context, snapshot.data.uid),
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
  final String description;
  final String uid;
  List<dynamic> participant;
  final int favorites;
  final int downloads;
  final int comment;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['writer'] != null),
        assert(map['description'] != null),
        assert(map['image'] != null),
        assert(map['favorites'] != null),
        assert(map['downloads'] != null),
        assert(map['comment'] != null),
        assert(map['participant'] != null),
        uid = reference.documentID,
        name = map['name'],
        writer = map['writer'],
        description = map['description'],
        image = map['image'],
        favorites = map['favorites'],
        downloads = map['downloads'],
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
