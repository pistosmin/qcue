import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'record.dart';

class SearchPage extends StatefulWidget{
  String query='';
  bool searched=false;
  @override
  SearchPageState createState() {
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {

  final _queryController = TextEditingController();
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('ongoing_quests').where('name',isEqualTo :widget.query).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return Container(
          child: GridView.count(
            crossAxisCount: 1,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 7.0 / 3.0,
            children: _buildGridCards(context, snapshot.data.documents),
          ),
        );
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
              aspectRatio: 10 / 9,
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
                  Text(record.explanation, style: TextStyle(fontSize: 13.0))
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
        title: Text('Search'),
        iconTheme: new IconThemeData(color: Colors.white),
        // backgroundColor: Colors.orange[800],
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[            
              Expanded(
                child: TextField(
                  controller: _queryController,
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  setState(() {
                  widget.searched=true;
                    widget.query=_queryController.text;
                    build(context);
                  });
                },
              )
            ],
          ),
          Flexible(
            child:
            widget.searched?  _buildBody(context): new Container(width: 1,height: 1,),
            
          ),

        ],
      )
    );
  }
}