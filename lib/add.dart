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
    return  AddPageState();
  }
}

class AddPageState extends State<AddPage> {

  final FirebaseStorage storage = FirebaseStorage.instance;

  final _questTitleController = TextEditingController();
  final _questDescriptionController = TextEditingController();
  final _questCategoryController = TextEditingController();

  // quest lists parameters
  String _creatorUID;
  String _creatorName;

  bool _isPublic = false;
  bool _isPeriod = false;
  bool _isAllDay = false;

  bool _isClear = false;
  int _comments = 0;
  int _downloads = 0;
  int _favoritesrites = 0;

  String _questTitle;
  String _description;

  List<String> _listTag = new List();
  String category;

  String _imageUrl;
  File _image;
  // String defaultImageUrl =
  //     'https://firebasestorage.googleapis.com/v0/b/realfinal-a0b57.appspot.com/o/default.png?alt=media&token=b1d44724-0984-4232-969c-29564b4d6119';
  String defaultImageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjhJ_fE8brBZTj3ZXyqbs00etqFS7shBubvpVai0p0NkY7fHaZ-g';

  DateTime _dateCreated;
  DateTime _dateModified;

  // flags for the creating quest list
  //static bool uploadFlag = true;
  bool _saveNeeded = false;
  bool _hasTitle = false;
  bool _hasDescription = false;


  // static bool uploadFlag = true;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // uploadFlag = false;
    setState(() {
      _image = image;
    });
  }

  Future<bool> _onWillPop() async {
    // TODO 타이틀은 없고 디스크립션이 있을 때 자동으로 제목없음 이라는 타이틀과 함께 퀘스트를 생성할 것
    _saveNeeded = _hasTitle || _saveNeeded; //_hasLocation || _hasName || _saveNeeded;
    if (!_saveNeeded) return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('퀘스트 작성을 취소할까요?', style: dialogTextStyle),
              actions: <Widget>[
                FlatButton(
                    child: const Text('취소'),
                    onPressed: () {
                      Navigator.of(context).pop(
                          false); // Pops the confirmation dialog but not the page.
                    }),
                FlatButton(
                    child: const Text('삭제'),
                    onPressed: () {
                      Navigator.of(context).pop(
                          true); // Returning true to _onWillPop will pop again.
                    })
              ],
            );
          },
        ) ??
        false;
  }  

  Widget _addQuest(){
    return StreamBuilder(
            stream: FirebaseAuth.instance.currentUser().asStream(),
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
                return  Form(
                  onWillPop: _onWillPop,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       Center(
                        child: _image == null
                            ?  Image.network(
                                defaultImageUrl,
                                height: 250,
                              )
                            :  Image.file(
                                _image,
                                height: 250.0,
                              ),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: getImage,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        alignment: Alignment.bottomLeft,
                        child: TextField(
                          controller: _questTitleController,
                          autofocus: true,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'New Quest Title',
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _hasTitle = value.isNotEmpty;
                              if (_hasTitle) {
                                _questTitle = value;
                                _saveNeeded = true;
                              }
                            });
                          }
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        alignment: Alignment.bottomLeft,
                        child: TextField(
                          controller: _questDescriptionController,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Enter The Description',
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _hasDescription = value.isNotEmpty;
                              if (_hasDescription) {
                                _description = value;
                                _saveNeeded = true;
                              }
                            });
                          },
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        alignment: Alignment.bottomLeft,
                        child: TextField(
                          controller: _questCategoryController,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Select Category',
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _hasTitle = value.isNotEmpty;
                              if (_hasTitle) {
                                category= value;
                                _saveNeeded = true;
                              }
                            });
                          }
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text('CLEAR'),
                            onPressed: () {
                              _questTitleController.clear();
                              _questDescriptionController.clear();
                              _questCategoryController.clear();
                            },
                          ),
                          RaisedButton(
                            child: Text('CREATE'),
                            onPressed: () async {
                                    if (_image == null) {
                                      _imageUrl = defaultImageUrl;
                                    } else {
                                      final StorageReference refer = storage.ref().child('picture').child(DateTime.now().toString());
                                      final StorageUploadTask task = refer.putFile(_image);
                                      _imageUrl = await (await task.onComplete).ref.getDownloadURL();                                  
                                    }
                                    _questTitle = _questTitleController.text;
                                    _description = _questDescriptionController.text;
                                    category = _questCategoryController.text;

                                    final String _questUid = Uuid().v1();

                                    _dateCreated = DateTime.now();
                                    _dateModified = DateTime.now();

                                    Firestore.instance.collection('ongoing_quests').document().setData({
                                      'questUID': _questUid,
                                      'name': _questTitle,
                                      'description': _description,

                                      'image': _imageUrl,

                                      'writer': snapshot.data.uid,
                                      'creatorName': snapshot.data.displayName,
                                      
                                      'category': category,
                                      'isClear': _isClear,

                                      'comment': _comments,
                                      'downloads': _downloads,
                                      'favorites': _favoritesrites,

                                      'participant': snapshot.data.uid,

                                      'dateCreated': _dateCreated,
                                      'dateModified': _dateModified,
                                    });
                                    print('Upload Complete');
                                    Navigator.pop(context);
                                  }
                          ),
                        ],
                      ),
                    ],
                  ),
                );
            });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_hasTitle ? _questTitle : '새로운 퀘스트', style: TextStyle(color: Colors.orange[800]),),
        iconTheme:  IconThemeData(color: Colors.orange[800]),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.orange[50],
      ),
      body: SingleChildScrollView(
        child: _addQuest()
      ),
      backgroundColor: Colors.orange[50],
    );
  }
}
