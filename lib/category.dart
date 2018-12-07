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
// import 'dropMenu.dart';
import 'drawer.dart';

class CategoryPage extends StatefulWidget {
  String category;
  CategoryPage({
    Key key,
    @required this.category,
  }) : super(key: key);
  @override
  CategoryPageState createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

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

  Widget _buildBody(BuildContext context, String uid) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ongoing_quests')
          .where('category',
              isEqualTo:
                  widget.category) // 이부분으로써 uid가 participant에 있는지를 확인 할 수 있다.
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
      // print('this is hero tag ${ongoing_quests.documentID}');
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: '${ongoing_quests.documentID}',
              // tag: 'detail',
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: 
                  Image.network(
                    record.image,
                    width: double.infinity,
                    height: 130.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.fromLTRB(24.0, 4.0, 24.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    record.name,
                    style: TextStyle(fontSize: 18.0, color: Colors.orange[800]),
                  ),
                  Text(
                    record.description,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 10,),
                IconButton(
                  icon: record.favorites ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border, color: Colors.orange[800],),
                  onPressed: (){
                    if (record.favorites == false) {
                      // _isFavorited[record] = true;
                      Firestore.instance
                          .collection('ongoing_quests')
                          .document(record.reference.documentID)
                          .updateData({'favorites': true});
                    } else {
                      // _isFavorited = false;
                      Firestore.instance
                          .collection('ongoing_quests')
                          .document(record.reference.documentID)
                          .updateData({'favorites': false});
                    }
                  }
                ),
                GestureDetector(
                  onTap: (){
                    if (record.favorites == false) {
                      // _isFavorited[] = true;
                      Firestore.instance
                          .collection('ongoing_quests')
                          .document(record.reference.documentID)
                          .updateData({'favorites': true});
                    } else {
                      // _isFavorited = false;
                      Firestore.instance
                          .collection('ongoing_quests')
                          .document(record.reference.documentID)
                          .updateData({'favorites': false});
                    }
                  },
                  child: Text("LIKE",
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15.0, fontWeight: FontWeight.bold), ),
                ), 
                SizedBox(width: 30,),
                IconButton(
                  icon: Icon(Icons.file_download, color: Colors.orange[900],),
                  onPressed: () {
                    if (record.participant.contains(uid)) {
                      print('already have');
                    } else {
                      final List tempList = [];
                      for (var x = 0;
                          x < record.participant.length;
                          x++) {
                        tempList.add(record.participant.elementAt(x));
                      }
                      print(tempList.toString());
                      tempList.add(uid);
                      print(tempList.toString());
                      Firestore.instance
                          .collection('ongoing_quests')
                          .document(record.reference.documentID)
                          .updateData({'participant': tempList});
                      print('added');
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if (record.participant.contains(uid)) {
                      print('already have');
                    } else {
                      final List tempList = [];
                      for (var x = 0;
                          x < record.participant.length;
                          x++) {
                        tempList.add(record.participant.elementAt(x));
                      }
                      print(tempList.toString());
                      tempList.add(uid);
                      print(tempList.toString());
                      Firestore.instance
                          .collection('ongoing_quests')
                          .document(record.reference.documentID)
                          .updateData({'participant': tempList});
                      print('added');
                    }
                  },
                  child: Text("GET",
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15.0, fontWeight: FontWeight.bold),),
                ),
                SizedBox(width: 30,),
                FlatButton(
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
                                description: record.description,
                                creatorName:record.creatorName,
                              ),
                        ));
                  },
                  child: new Text('MORE',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15.0, fontWeight: FontWeight.bold),),
                ),
                SizedBox(width: 10,),
              ],
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
        title: Text(widget.category, style: TextStyle(color: Colors.orange[800]),),
        iconTheme:  IconThemeData(color: Colors.orange[800]),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.orange[50],
      ),
      // drawer: CustomDrawer(),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.currentUser().asStream(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          return Center(
            child: _buildBody(context, snapshot.data.uid),
          );
        },
      ),
    );
  }
}

class Record {
  final String name;
  final String creatorName;
  final String image;
  final String writer;
  final String description;
  final String uid;
  List<dynamic> participant;
  final bool favorites;
  final int downloads;
  final int comment;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['creatorName'] != null),
        assert(map['writer'] != null),
        assert(map['description'] != null),
        assert(map['image'] != null),
        assert(map['favorites'] != null),
        assert(map['downloads'] != null),
        assert(map['comment'] != null),
        assert(map['participant'] != null),
        uid = reference.documentID,
        name = map['name'],
        creatorName = map['creatorName'],
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

// class PhotoHero extends StatelessWidget {
//   const PhotoHero({Key key, this.photo, this.onTap, this.width, this.height})
//       : super(key: key);
//   final String photo;
//   final VoidCallback onTap;
//   final double width;
//   final double height;
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: Hero(
//         tag: photo,
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: onTap,
//             child: Image.network(
//               photo,
//               fit: BoxFit.fill,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


