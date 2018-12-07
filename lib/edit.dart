import 'dart:io';

import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class EditPage extends StatefulWidget{
  String documentID;
  String userUid;
  String creatorUid;
  String image;
  String photoUrl;
  String name;
  String description;
  EditPage({Key key, @required this.documentID, @required this.userUid, @required this.image, @required this.name, @required this.description}) : super(key: key);

  @override
  EditPageState createState() {
    return new EditPageState();
  }
}

class EditPageState extends State<EditPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
        // final  _nameController = TextEditingController(text: quest.name);
        // final  _descriptionController = TextEditingController(text: quest.description);
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
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
      title: Text("Edit", style: TextStyle(color: Colors.orange[800]),),
      iconTheme: new IconThemeData(color: Colors.orange[800]),
      elevation: 0.3,
        backgroundColor: Colors.orange[50],

      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('ongoing_quests').document(widget.documentID).snapshots(),
        builder: (context,snapshot){

          if (!snapshot.hasData) return LinearProgressIndicator();
          final quest = Quest.fromSnapshot(snapshot.data);

          widget.photoUrl=quest.photoUrl;
                      

          return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: _image == null
                      ?new Image.network(quest.photoUrl,height: 250,)
                      :new Image.file(_image,height: 250.0,),
                    ),
                    IconButton(icon: Icon(Icons.camera_alt),onPressed: getImage,),
                    TextField(
                      
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Quest Name',
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Quest Description',
                      ),
                    ),

                    SizedBox(height: 5.0,),

                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('Clear'),
                          onPressed: () {
                            setState(() {              
                              _nameController.clear();
                              _descriptionController.clear();
                            });
                          },
                        ),
                        RaisedButton(
                          child: Text('Save'),
                          // onPressed: _image==null? null: () async {
                          onPressed: () async {
                            if(_image!=null) {
                              final StorageReference refer = FirebaseStorage.instance.ref().child('picture').child(DateTime.now().toString());
                              final StorageUploadTask task = refer.putFile(_image);
                              widget.photoUrl = await ( await task.onComplete).ref.getDownloadURL();
                            }
                            print(widget.photoUrl);
                            String name =_nameController.text;
                            String description =_descriptionController.text;
                            Firestore.instance.collection('ongoing_quests').document(widget.documentID).updateData({'name':name,'description':description,'image':widget.photoUrl});
                            print('Upload Complete');
                            // Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                      ),
                                ));

                          }//
                          ,
                        ),
                      ],
                    ),
                  ]
          );
        }
      ),
    );
  }
}


class Quest {
  final String name;
  final String description;
  // final int downloads;
  final String isClear;
  final String photoUrl;
  final DocumentReference reference;

  Quest.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['description'] != null),
        // assert(map['downloads'] != null),
        assert(map['image'] != null),
        assert(map['isClear'] != null),
        name = map['name'],
        description = map['description'],
        photoUrl = map['image'],
        // downloads = map['downloads'],
        isClear = map['isClear'];

  Quest.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Quest<$name:>";
}