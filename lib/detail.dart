import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailPage extends StatefulWidget {
  String userID;
  String documentID;
  String name, image, writer, explanation;
  DetailPage(
      {Key key,
      @required this.userID,
      @required this.documentID,
      @required this.name,
      @required this.writer,
      @required this.explanation,
      @required this.image})
      : super(key: key);
  @override
  DetailPageState createState() => new DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  Widget _buildBody(BuildContext context, String uid) {
    // print(widget.documentID);
    print(widget.image);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ongoing_quests')
          .where('uid',
              isEqualTo:
                  widget.documentID) // 이부분으로써 uid가 participant에 있는지를 확인 할 수 있다.
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return titleSection(context, snapshot.data.documents, uid);
      },
    );
  }

  Widget titleSection(
      BuildContext context, List<DocumentSnapshot> snapshot, String uid) {
    // print(snapshot.toString());
    return Column(
      // padding: const EdgeInsets.only(top: 20.0),
      children: <Widget>[
        Container(
            // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  widget.image,
                  width: double.infinity,
                  color: Color.fromRGBO(0, 0, 0, 0.7),
                  colorBlendMode: BlendMode.darken,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.writer,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 25.0,
                        ),
                      ),
                      Center(
                        child: Text(
                          '\n\n\"' + widget.explanation + '\"',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )),
      ],
    );
  }

  Widget _questList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ongoing_quests')
          .document(widget.documentID)
          .collection('quest') // 이부분으로써 uid가 participant에 있는지를 확인 할 수 있다.
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return Expanded(
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
      final quest = Quest.fromSnapshot(ongoing_quests);
      return Card(
        child: Text(quest.name),
      );
    }).toList();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final quest = Quest.fromSnapshot(data);
    return Container(
      // key: ValueKey(quest.name),
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(quest.name),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
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
            return Container(
                child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.network(
                      widget.image,
                      width: double.infinity,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      colorBlendMode: BlendMode.darken,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20.0, left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.writer,
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 25.0,
                            ),
                          ),
                          Center(
                            child: Text(
                              '\n\n\"' + widget.explanation + '\"',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Text('data'),
                ),
                _questList(context),
              ],
            ));
          }
        },
      ),
    );
  }
}

class Quest {
  final String name;
  // final int down;
  final String isClear;
  final DocumentReference reference;

  Quest.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        // assert(map['down'] != null),
        assert(map['isClear'] != null),
        name = map['name'],
        // down = map['down'],
        isClear = map['isClear'];

  Quest.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Quest<$name:>";
}
// return Checkbox(
//   value: isClearvalue,
//   onChanged: (bool value) {
//     setState(() {
//       isClearvalue = true;
//       Firestore.instance.collection('ongoing_quests').document(widget.documentid).updateData({'isClear': 'true'});
//     });
//   },
// );

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
