import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryPage extends StatefulWidget {
  String category;
  CategoryPage({Key key, @required this.category}) : super(key: key);
  @override
  CategoryPageState createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> {
  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('quest').where('category', isEqualTo: widget.category).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildGridCards(context, snapshot.data.documents);
      },
    );
  }
  Widget _buildGridCards(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    if (snapshot == null || snapshot.isEmpty) {
      return GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: const <Card>[]);
    }

    final ThemeData theme = Theme.of(context);
    // final NumberFormat formatter = NumberFormat.simpleCurrency(
    //     locale: Localizations.localeOf(context).toString());

    return GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 10.0,
        children: snapshot.map((product) {
          final record = Record.fromSnapshot(product);
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                    aspectRatio: 18 / 11,
                    child: Image.network(
                      record.image,
                      fit: BoxFit.fitWidth,
                    )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          record.name,
                          style: theme.textTheme.title,
                          maxLines: 1,
                        ),
                        Text(
                          record.writer,
                          // style: theme.textTheme.title,
                          maxLines: 1,
                        ),
                        Text(
                          record.explanation,
                          // style: theme.textTheme.title,
                          maxLines: 1,
                        ),
                        Text(
                          record.category,
                          // style: theme.textTheme.title,
                          maxLines: 1,
                        ),
                        SizedBox(height: 5.0),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('quest').where('isClear', isEqualTo: 'false').snapshots(),
        builder: (context, snapshot) {
          return Container(
            child: _buildBody(context),
          );
        }
      ),
    );
  }
}

class Record {
  final String name;
  final String image;
  final String category;
  final String writer;
  final String explanation;
  final String uid;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['category'] != null),
        assert(map['explanation'] != null),
        assert(map['image'] != null),
        assert(map['writer'] != null),
        uid = reference.documentID,
        name = map['name'],
        category = map['category'],
        image = map['image'],
        explanation = map['explanation'],
        writer = map['writer'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$category>";
}
