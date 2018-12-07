// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


// class EditPage extends StatefulWidget{
//   String documentID;
//   String userUid;
//   String creatorUid;
//   String image;
//   EditPage({Key key, @required this.documentID, @required this.userUid}) : super(key: key);

//   @override
//   EditPageState createState() {
//     return new EditPageState();
//   }
// }

// class EditPageState extends State<EditPage> {
//   File _image;
//   Future getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = image;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//       leading: IconButton(
//             icon: Icon(
//               Icons.keyboard_backspace,
//               semanticLabel: 'back',
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//       centerTitle: true,
//       title: Text('Edit'),
//       ),
//       body: StreamBuilder(
//         stream: Firestore.instance.collection('ongoing_quests').document(widget.documentID).snapshots(),
//         builder: (context,snapshot){

//           if (!snapshot.hasData) return LinearProgressIndicator();
//           final record = Record.fromSnapshot(snapshot.data);
//           TextEditingController _nameController = TextEditingController(text: record.name);
//           TextEditingController _priceController = TextEditingController(text: record.price.toString());
//           widget.creatorUid=record.userUid;
//           widget.photoUrl=record.photoUrl;
//           return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     new Center(
//                       child: _image == null
//                       ?new Image.network(record.photoUrl,height: 250,)
//                       :new Image.file(_image,height: 250.0,),
//                     ),
//                     IconButton(icon: Icon(Icons.camera_alt),onPressed: getImage,),
//                     TextField(
                      
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         filled: true,
//                         labelText: 'Product Name',
//                       ),
//                     ),
//                     SizedBox(height: 5.0,),
//                     TextField(
//                       controller: _priceController,
//                       decoration: InputDecoration(
//                         filled: true,
//                         labelText: 'Product Price',
//                       ),
//                       keyboardType: TextInputType.number,
//                     ),

//                     SizedBox(height: 5.0,),
//                     new Center(
//                       child: new Text("creator's uid : ${record.userUid}")
//                     ),
//                     SizedBox(height: 5.0,),
//                     new Center(
//                       child: new Text("Uploaded : ${record.uploadTime}")
//                     ),
//                     SizedBox(height: 5.0,),
//                     new Center(
//                       child: new Text("Modified : ${record.modifiedTime}")
//                     ),

//                     ButtonBar(
//                       children: <Widget>[
//                         FlatButton(
//                           child: Text('Clear'),
//                           onPressed: () {
//                             _nameController.clear();
//                             _priceController.clear();
//                           },
//                         ),
//                         RaisedButton(
//                           child: Text('Save'),
//                           onPressed: _image==null? null: () async {
//                             final StorageReference refer = FirebaseStorage.instance.ref().child('picture').child(DateTime.now().toString());
//                             final StorageUploadTask task = refer.putFile(_image);
//                             widget.photoUrl = await ( await task.onComplete).ref.getDownloadURL();
//                             // widget.photoUrl = temp;
//                             print(widget.photoUrl);
//                             String name =_nameController.text;
//                             int price=int.tryParse(_priceController.text.toString());
//                             Firestore.instance.collection('product').document(widget.itemuid).updateData({'name':name,'price':price,'photoUrl':widget.photoUrl,'modifiedTime':DateTime.now()});
//                             print('Upload Complete');
//                             Navigator.pop(context);
//                           }
//                           ,
//                         ),
//                       ],
//                     ),
//                   ]
//           );
//         }
//       ),
//     );
//   }
// }

// class Record {
//   final String name;
//   final String photoUrl;
//   final int price;
//   final String uid;
//   final String userUid;
//   final DateTime uploadTime;
//   final DateTime modifiedTime;
//   final DocumentReference reference;
  
//   Record.fromMap(Map<String, dynamic> map, {this.reference})
//       : assert(map['name'] != null),
//         assert(map['price'] != null),
//         assert(map['photoUrl'] != null),
//         assert(map['userUid'] != null),
//         assert(map['uploadTime'] != null),
//         assert(map['modifiedTime'] != null),
//         uid = reference.documentID,
//         name = map['name'],
//         price = map['price'],
//         userUid = map['userUid'],
//         uploadTime = map['uploadTime'],
//         modifiedTime = map['modifiedTime'],
//         photoUrl = map['photoUrl'];

//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data, reference: snapshot.reference);

//   @override
//   String toString() => "Record<$name:$price>";
// }
