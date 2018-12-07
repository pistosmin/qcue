
import 'package:flutter/material.dart';

//firebase packages
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ViewQuest extends StatefulWidget {
  const ViewQuest({Key key}) : super(key: key);
  @override
  ViewQuestState createState() => ViewQuestState();
}

class ViewQuestState extends State<ViewQuest> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(),
    );
  }
}