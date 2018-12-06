import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String name;
  final String image;
  final String writer;
  final String category;
  final String explanation;
  final String uid;
  List<dynamic> participant;
  final int favo;
  final int down;
  final int comment;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['writer'] != null),
        assert(map['explanation'] != null),
        assert(map['image'] != null),
        assert(map['favo'] != null),
        assert(map['down'] != null),
        assert(map['comment'] != null),
        assert(map['participant'] != null),
        uid = reference.documentID,
        name = map['name'],
        writer = map['writer'],
        explanation = map['explanation'],
        image = map['image'],
        category = map['category'],
        favo = map['favo'],
        down = map['down'],
        comment = map['comment'],
        participant = map['participant'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$writer>";
}