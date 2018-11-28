import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddPage extends StatefulWidget {
  @override
  AddPageState createState() {
    return new AddPageState();
  }
}

class AddPageState extends State<AddPage> {
  File _image;
  String name;
  String url =
      'https://firebasestorage.googleapis.com/v0/b/realfinal-a0b57.appspot.com/o/default.png?alt=media&token=b1d44724-0984-4232-969c-29564b4d6119';
  String explanation;
  String category;
  static bool uploadFlag = true;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    uploadFlag = false;
    setState(() {
      _image = image;
    });
  }

  final _nameController = TextEditingController();
  final _explanationController = TextEditingController();
  final _categoryController = TextEditingController();
  final FirebaseStorage storage = FirebaseStorage.instance;

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
          title: Text('Add'),
        ),
        body: StreamBuilder(
            stream: FirebaseAuth.instance.currentUser().asStream(),
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.data.isAnonymous) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('You are Guest'),
                    Text('Please Login First'),
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
                return new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: _image == null
                          ? new Image.network(
                              url,
                              height: 250,
                            )
                          : new Image.file(
                              _image,
                              height: 250.0,
                            ),
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: getImage,
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Quest Name',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: _explanationController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'explanation',
                      ),
                    ),
                    TextField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'category',
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('Clear'),
                          onPressed: () {
                            _nameController.clear();
                            _explanationController.clear();
                            _categoryController.clear();
                          },
                        ),
                        RaisedButton(
                          child: Text('Register'),
                          onPressed: _image == null
                              ? () async {
                                  name = _nameController.text;
                                  explanation = _explanationController.text;
                                  category = _categoryController.text;
                                  final String uuid = Uuid().v1();
                                  Firestore.instance
                                      .collection('quest')
                                      .document(name)
                                      .setData({
                                    'name': name,
                                    'image': url,
                                    // 'uploadTime': DateTime.now(),
                                    // 'modifiedTime': DateTime.now(),
                                    'writer': snapshot.data.uid,
                                    'explanation': explanation,
                                    'category': category,
                                  });
                                  print('Upload Complete');
                                  Navigator.pop(context);
                                }
                              : () async {
                                  final StorageReference refer = FirebaseStorage
                                      .instance
                                      .ref()
                                      .child('picture')
                                      .child(DateTime.now().toString());
                                  final StorageUploadTask task =
                                      refer.putFile(_image);
                                  url = await (await task.onComplete)
                                      .ref
                                      .getDownloadURL();
                                  print(url);
                                  name = _nameController.text;
                                  explanation = _explanationController.text;
                                  category = _categoryController.text;
                                  final String uuid = Uuid().v1();
                                  Firestore.instance
                                      .collection('product')
                                      .document(name)
                                      .setData({
                                    'name': name,
                                    'image': url,
                                    // 'uploadTime': DateTime.now(),
                                    // 'modifiedTime': DateTime.now(),
                                    'writer': snapshot.data.uid,
                                    'explanation': explanation,
                                    'category': category,
                                  });
                                  print('Upload Complete');
                                  Navigator.pop(context);
                                },
                        ),
                      ],
                    ),
                  ],
                );
              }
            }));
  }
}

class Record {
  final String name;
  final String photoUrl;
  final int price;
  final String uid;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['price'] != null),
        assert(map['photoUrl'] != null),
        uid = reference.documentID,
        name = map['name'],
        price = map['price'],
        photoUrl = map['photoUrl'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$price>";
}
