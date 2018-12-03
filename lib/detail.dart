import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailPage extends StatefulWidget {
  String name;
  DetailPage({Key key, @required this.name}) : super(key: key);
  @override
  DetailPageState createState() => new DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  // void _changeValue(){
  //   setState(() {
  //         isClearvalue = true;
  //         Firestore.instance.collection('ongoing_quests').document(widget.name).updateData({'isClear': 'true'});
  //       });
  // }
  bool isClearvalue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            semanticLabel: 'back',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('Detail'),
      ),
      body: 
      // StreamBuilder(
          // stream: Firestore.instance
          //     .collection('ongoing_quests')
          //     .where('name', isEqualTo: widget.name)
          //     .snapshots(),
          // builder: (context, snapshot) {
            // if (!snapshot.hasData) return LinearProgressIndicator();
            // final vrecord = Record.fromSnapshot(snapshot.data);
            // return 
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // new Center(
                  //     child: new Image.network(
                  //   vrecord.image,
                  //   height: 250,
                  // )),
                  SizedBox(
                    height: 10.0,
                  ),
                  new Center(child: new Text('name: ${widget.name}')),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // new Center(child: new Text("writer : ${record.writer}")),
                  SizedBox(
                    height: 10.0,
                  ),
                  // new Center(
                  //     child: new Text("explanation : ${record.explanation}")),
                  StreamBuilder(
                      stream: Firestore.instance
                          .collection('ongoing_quests')
                          .where('name', isEqualTo: widget.name)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return Checkbox(
                          value: isClearvalue,
                          onChanged: (bool value) {
                            setState(() {
                              isClearvalue = true;
                              Firestore.instance.collection('ongoing_quests').document(widget.name).updateData({'isClear': 'true'});
                            });
                          },
                        );
                      }),
                ]),
          // }),
    );
  }
}

class Record {
  final String name;
  final String image;
  final String writer;
  final String explanation;
  final String uid;
  final String isClear;
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
        assert(map['isClear'] != null),
        uid = reference.documentID,
        name = map['name'],
        writer = map['writer'],
        explanation = map['explanation'],
        image = map['image'],
        favo = map['favo'],
        down = map['down'],
        isClear = map['isClear'],
        comment = map['comment'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$writer>";
}
