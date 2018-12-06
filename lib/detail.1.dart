import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'edit.dart';

class DetailItemScreen extends StatefulWidget {
  DetailItemScreen({Key key, @required this.itemUID, @required this.userUID})
      : super(key: key);
  final String itemUID;
  final String userUID;

  @override
  _DetailItemState createState() => new _DetailItemState();
}

class _DetailItemState extends State<DetailItemScreen> {
  String usUID;

  Widget _buildEdit(snapshot, usUID) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (usUID != widget.userUID) {
        print('test');
        return Icon(
          Icons.edit,
          semanticLabel: 'no_edit',
        );
      } else if (usUID == widget.userUID) {
        // return IconButton(
        //     icon: Icon(
        //       Icons.edit,
        //       semanticLabel: 'edit',
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => new EditItemScreen(
        //                 itemUID: widget.itemUID, userUID: widget.userUID, crUID: usUID)),
        //       );
        //     });
      }
    } else {
      return Icon(
        Icons.edit,
        semanticLabel: 'no_edit',
      );
    }
  }

  Widget _buildDel(snapshot, usUID) {
    if (snapshot.connectionState == ConnectionState.done) {
      print(usUID);
      if (usUID != widget.userUID) {
        return Icon(
          Icons.delete,
          semanticLabel: 'no_delete',
        );
      } else if (usUID == widget.userUID) {
        return IconButton(
            icon: Icon(
              Icons.delete,
              semanticLabel: 'delete',
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
              print('delete button');
              Firestore.instance.collection('items').document(widget.itemUID).delete();
            });
      }
    } else {
      return Icon(
        Icons.delete,
        semanticLabel: 'no_delete',
      );
    }
  }



  Widget _buildDetail() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('items')
            .document(widget.itemUID)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          final item = Record.fromSnapshot(snapshot.data);
          // uuuu = item;
          usUID = item.creatorUID;
          return ListView(
            children: <Widget>[
              Image.network(
                item.image_url,
                height: 260,
              ),
              Container(
                child: Text(
                  item.name,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  item.price.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(),
              Container(
                child: Text(
                  item.description,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  '<uid> ' + item.creatorUID,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  item.crTime.toString() + ' created',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  item.edTime.toString() + ' edited',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.currentUser().asStream(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          // print(snapshot.data.uid);
          // print(widget.userUID);
          return new Scaffold(
            appBar: AppBar(
              title: Text("Detail"),
              centerTitle: true,
              actions: <Widget>[_buildEdit(snapshot, usUID), _buildDel(snapshot, usUID)],
            ),
            body: _buildDetail(),
          );
        });
  }
}

class Record {
  final String name;
  final int price;
  final String image_url;
  final DocumentReference reference;
  final String itemUID;
  final String description;
  final DateTime crTime;
  final DateTime edTime;

  final String creatorUID;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['price'] != null),
        assert(map['image_url'] != null),
        // assert(map['description'] != null),

        // assert(map['itemUID'] != null),
        itemUID = reference.documentID,
        name = map['name'],
        price = map['price'],
        image_url = map['image_url'],
        description = map['description'],
        crTime = map['created'],
        edTime = map['edited'],
        creatorUID = map['creatorUID'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$price:$price>";
}
