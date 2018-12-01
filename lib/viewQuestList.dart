
import 'package:flutter/material.dart';

//firebase packages
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ViewQuestList extends StatefulWidget {
  const ViewQuestList({Key key}) : super(key: key);
  @override
  ViewQuestListState createState() => ViewQuestListState();
}

class ViewQuestListState extends State<ViewQuestList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(),

    );
  }
}