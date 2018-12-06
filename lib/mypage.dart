
import 'package:flutter/material.dart';

//firebase packages
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key key}) : super(key: key);
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(),
      
    );
  }
}