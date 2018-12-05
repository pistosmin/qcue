import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailPage extends StatefulWidget {
  String documentid;
  String image;
  DetailPage({Key key, @required this.documentid, @required this.image}) : super(key: key);
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
//   bool isClearvalue = false;
//   @override
//   Widget build(BuildContext context) {
//     print(widget.documentid);
//     return Scaffold(
//       appBar: AppBar(
//         // leading: IconButton(
//         //   icon: Icon(
//         //     Icons.keyboard_backspace,
//         //     semanticLabel: 'back',
//         //   ),
//         //   onPressed: () {
//         //     Navigator.pop(context);
//         //   },
//         // ),
//         // centerTitle: true,
//         title: Text('Detail'),
//       ),
//       body: 
//       // StreamBuilder(
//           // stream: Firestore.instance
//           //     .collection('ongoing_quests')
//           //     .where('name', isEqualTo: widget.name)
//           //     .snapshots(),
          // builder: (context, snapshot) {
          //   if (!snapshot.hasData) return LinearProgressIndicator();
          //   final vrecord = Record.fromSnapshot(snapshot.data);
          //   return 
//             Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   // new Center(
//                   //     child: new Image.network(
//                   //   vrecord.image,
//                   //   height: 250,
//                   // )),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   new Center(child: new Text('name: ${widget.documentid}')),
//                   // SizedBox(
//                   //   height: 10.0,
//                   // ),
//                   // new Center(child: new Text("writer : ${record.writer}")),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   // new Center(
//                   //     child: new Text("explanation : ${record.explanation}")),
//                   StreamBuilder<QuerySnapshot>(
//                     stream: Firestore.instance
//                         .collection('ongoing_quests')
//                         .document(widget.documentid)
//                         .collection('quest')
//                         // .where('documentid', isEqualTo: widget.documentid)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) return LinearProgressIndicator();
//                       return Container(
//                         child: GridView.count(
//                           crossAxisCount: 1,
//                           children: _buildCheckBox(context, snapshot.data.documents)

//                         ),
//                       );

//                     }
//                   ),
//                 ]
//               ),
//           // }),
//     );
//   }
// }

// List <Card> _buildCheckBox(BuildContext context, List<DocumentSnapshot>  documents){
//     if (documents == null || documents.isEmpty) {
//       return const [];
//     }
//     return documents.map((document) {
//       final quest = Quest.fromSnapshot(document);
//       print(quest.toString());
//       return Card(child:  
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             AspectRatio(
//               aspectRatio: 10 / 9,
//               child: new Image.network(
//                 'https://firebasestorage.googleapis.com/v0/b/final-project-62557.appspot.com/o/picture%2F2018-12-02%2012:25:23.974035?alt=media&token=6175c461-4022-41ad-8858-fb23a1657527',
//                 height: 100.0,
//                 width: 100.0,
//                 fit: BoxFit.fill,
//               ),
//             ),
//             Text('Quest Name : '+quest.name),
//           ],
//         ),
//       );
//     }).toList();

// }

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text('Detail'),
    ),
    body: StreamBuilder(
        stream: Firestore.instance
          .collection('ongoing_quests')
          .where('name',
              isEqualTo: widget.documentid) // 이부분으로써 uid가 participant에 있는지를 확인 할 수 있다.
          .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            final vrecord = Quest.fromSnapshot(snapshot.data);
            return Container(
              child: Text(vrecord.name),
            );

        },
    ),





    // ListView(
    //   children: <Widget>[
    //     Image.network(
    //       widget.image,
    //       width: double.infinity,
    //     ),
    //     Center(
    //       child: Text('r'),
    //     )

    //   ],
    // ),
  );
}
}

class Quest {
  final String name;
  final String isClear;
  final DocumentReference reference;

  Quest.fromMap(Map<String,dynamic>map,{this.reference})
    :
    assert(map['name']!=null),
    assert(map['isClear']!=null),
    name = map['name'],
    isClear = map['isClear'];

  Quest.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Quest<$name:$isClear>";

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
