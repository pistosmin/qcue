// dart packages
import 'dart:async';
import 'dart:io';

// flutter packages
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// firebase packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'questList.dart';
import 'quest.dart';
import 'DateTimeItem.dart';

class CreateQuestPage extends StatefulWidget {
  @override
  CreateQuesState createState() => new CreateQuesState();
}

class CreateQuesState extends State<CreateQuestPage> {
  // firebase instance
  final FirebaseStorage storage = FirebaseStorage.instance;

  // text editing controllers of the list -> title, description, tags
  final _questTitleController = TextEditingController();
  final _questDesctiptionController = TextEditingController();
  final _questTagController = TextEditingController();

  // quest lists parameters
  String _creatorUID;
  String _creatorName;

  String _questTitle;
  String _questDescription;

  DateTime _dateEventStart = DateTime.now();
  DateTime _dateEventEnd = DateTime.now();
  DateTime _dateCreated;
  DateTime _dateModified;

  String _location;
  List<String> _questTag = new List();
  String category;

  String _imageUrl;
  File _image;
  bool _isPublic = false;
  bool _isPeriod = false;
  bool _isAllDay = false;

  // flags for the creating quest list
  //static bool uploadFlag = true;
  bool _saveNeeded = false;
  bool _hasTitle = false;
  bool _hasDescription = false;

  String defaultImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/realfinal-a0b57.appspot.com/o/default.png?alt=media&token=b1d44724-0984-4232-969c-29564b4d6119';

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // uploadFlag = false;
    setState(() {
      _image = image;
    });
  }

  Future _getFirebaseUser() async{
    StreamBuilder(
      stream: FirebaseAuth.instance.currentUser().asStream(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        _creatorUID = snapshot.data.uid;
        _creatorName = snapshot.data.displayName;
      },
    );
  }

  Widget _addQuestList() {
    //add Quest List
    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.currentUser().asStream(),
    //   builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        return Form(
          onWillPop: _onWillPop,
          child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: _image == null
                        ? new Image.network(
                            defaultImageUrl,
                            height: 100,
                          )
                        : new Image.file(
                            _image,
                            height: 100.0,
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
                        labelText: 'New List Title',
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
                      controller: _questDesctiptionController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Enter The Description',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _hasDescription = value.isNotEmpty;
                          if (_hasDescription) {
                            _questDescription = value;
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
                      controller: _questTagController,
                      autofocus: true,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Add Tag',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    onPressed: null,
                  ),
                  //TODO add버튼을 누르면 태그가 추가되고 추가된 태그가 줄줄히 뜨도록 지울 수 있는 태그 목록을 만든다
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      children: <Widget> [
                        Checkbox(
                            value: _isPublic,
                            onChanged: (bool value) {
                              setState(() {
                                _isPublic = value;
                              });
                            },
                          ),
                        const Text('공개'),
                      ]
                    )
                  ),
                  Container(
                    child: Row(
                      children: <Widget> [
                        Checkbox(
                          value: _isPeriod,
                          onChanged: (bool value) {
                            setState(() {
                              _isPeriod = value;
                            });
                          },
                        ),
                        const Text('기간'),
                      ]
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('시작',),
                        DateTimeItem(
                          dateTime: _dateEventStart,
                          onChanged: (DateTime value) {
                            setState(() {
                              _dateEventStart = value;
                            });
                          }
                        )
                      ]
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('끝',),
                        DateTimeItem(
                          dateTime: _dateEventEnd,
                          onChanged: (DateTime value) {
                            setState(() {
                              _dateEventEnd = value;
                            });
                          }
                        ),
                      ]
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget> [
                        Checkbox(
                          value: _isAllDay,
                          onChanged: (bool value) {
                            setState(() {
                              _isAllDay = value;
                            });
                          },
                        ),
                        const Text('하루 종일인가요?'),
                      ]
                    )
                  ),                  


                  RaisedButton(
                    child: Text('CREATE LIST'),
                    //form validation 추가
                    onPressed: () async {
                      if (_image == null) {
                        _imageUrl = defaultImageUrl;
                      } else {
                        final StorageReference refer = storage.ref().child('picture').child(DateTime.now().toString());
                        final StorageUploadTask task = refer.putFile(_image);
                        _imageUrl = await (await task.onComplete).ref.getDownloadURL();                                  
                      }

                      await _getFirebaseUser();
                      // _questTitle = _questTitleController.text;
                      // _questDescription = _questDesctiptionController.text;

                      final String _questUid = Uuid().v1();

                      // _dateEventStart = DateTime.now();
                      // _dateEventEnd = DateTime.now();
                      _dateCreated = DateTime.now();
                      _dateModified = DateTime.now();

                      Firestore.instance.collection('questLists').document(_questUid).setData({
                        'listUID': _questUid,
                        'listTitle': _questTitle,
                        'listDescription': _questDescription,

                        'creatorUID': _creatorUID,
                        'creatorName': _creatorName,

                        'listImageUrl': _imageUrl,

                        'category': category,
                        'listTag': _questTag,

                        // 'location': _location,
                        'isPublic' : _isPublic,
                        'isPeriod' : _isPeriod,
                        'dateEventStart': _dateEventStart,
                        'dateEventEnd': _dateEventEnd,

                        'dateCreated': _dateCreated,
                        'dateModified': _dateModified,
                      });
                      print('Upload Complete');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
        );
    //   }
    // );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_hasTitle ? _questTitle : '새로운 리스트'),
          actions: <Widget>[],
        ),
        body: SingleChildScrollView(
            child: _addQuestList()
          )
        );
  }
}
