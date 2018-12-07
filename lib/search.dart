import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  String query='';
  bool searched=false;
  @override
  SearchPageState createState() {
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {

  bool _searched = false;
  final _queryController = TextEditingController();
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('ongoing_quests').where('name',isEqualTo :widget.query).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        // else if (!snapshot.hasData && _searched == false) {
        //   return Center(
        //     child: Text("No Search Result"),
        //   );
        // }
        else {
          // _searched = false;
          return Container(
            child: GridView.count(
              crossAxisCount: 1,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 7.0 / 3.0,
              children: _buildGridCards(context, snapshot.data.documents),
            ),
          );
        }
      },
    );
  }

  List<Card> _buildGridCards(
      BuildContext context, List<DocumentSnapshot> documents) {
        
    if (documents == null || documents.isEmpty) {
      return const [];
    }
    return documents.map((ongoing_quests) {
      final record = Record.fromSnapshot(ongoing_quests);
      print(ongoing_quests.data.toString());
      return Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 9 / 9,
              child: new Image.network(
                record.image,
                height: 100.0,
                width: 100.0,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(record.name,
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold)),
                  Text(record.writer,
                      style: TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.bold)),
                  Text(record.description, style: TextStyle(fontSize: 13.0))
                ],
              ),
            )),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _queryController, 
                autofocus: true, style: 
                TextStyle(fontSize: 18, color: Colors.orange[800]),
                decoration: InputDecoration(
                  hintText: "search",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,

                    )
                  )
                ),
              )),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                // _searched = true;
                setState(() {
                  widget.searched=true;
                  widget.query=_queryController.text;
                  build(context);
                });
              },
            )
          ],
        ),
        iconTheme: new IconThemeData(color: Colors.orange[800]),
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.orange[50],
      ),
      body: Column(
        children: <Widget>[
          // Row(
          //   children: <Widget>[            
          //     Expanded(
                // child: 
                // TextField(
                //   controller: _queryController,
                // ),
          //     ),
          //     IconButton(
          //       icon: Icon(Icons.search),
          //       onPressed: (){
          //         setState(() {
          //         widget.searched=true;
          //           widget.query=_queryController.text;
          //           build(context);
          //         });
          //       },
          //     )
          //   ],
          // ),
          Flexible(
            child:
            widget.searched?  _buildBody(context): new Container(width: 1,height: 1,),
            
          ),

        ],
      )
    );
  }
}

class Record {
  final String name;
  final String image;
  final String writer;
  final String description;
  final String uid;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['writer'] != null),
        assert(map['description'] != null),
        assert(map['image'] != null),
        uid = reference.documentID,
        name = map['name'],
        writer = map['writer'],
        description = map['description'],
        image = map['image'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$writer>";
}