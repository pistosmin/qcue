import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Widget gridSection = new Expanded(
    flex: 1,
    child: new GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _generateGridItems().map((String value) {
          return _displayGridItem(value);
        }).toList()),
  );

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;
  final List<Widget> _children = [];

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('ongoing_quests').snapshots(),
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
                  Text(record.explanation, style: TextStyle(fontSize: 13.0))
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
              children: <Widget>[
                new SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: new Carousel(
                      images: [
                        new NetworkImage(
                            'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                        new NetworkImage(
                            'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                      ],
                    )),
                DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: <Widget>[
                      TabBar(
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
                        height: 300.0,
                        child: TabBarView(
                          children: <Widget>[
                            Center(
                              child: _buildBody(context),
                            ),
                            Center(
                              child: Text('완료한 퀘스트 여기'),
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
                ListTile(
                  title: Text(
                    '카테고리별 퀘스트 보기',
                    textAlign: TextAlign.center,
                  ),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                gridSection,
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
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
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['writer'] != null),
        assert(map['explanation'] != null),
        assert(map['image'] != null),
        uid = reference.documentID,
        name = map['name'],
        writer = map['writer'],
        explanation = map['explanation'],
        image = map['image'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$writer>";
}

List<String> _generateGridItems() {
  List<String> gridItems = new List<String>();
  for (int i = 0; i < 6; i++) {
    if(i==0){
      gridItems.add('study');
    }
    else if(i==1){
      gridItems.add('sports');
    }
    else if(i==2){
      gridItems.add('diet');
    }
    else if(i==3){
      gridItems.add('travel');
    }
    else if(i==4){
      gridItems.add('cook');
    }
    else if(i==5){
      gridItems.add('all');
    }
  }
  return gridItems;
}

Widget _displayGridItem(String value) {
  return new Container(
    padding: new EdgeInsets.all(8.0),
    color: new Color(0XFFFFFFFF),
    child: new Text(value),
  );
}
