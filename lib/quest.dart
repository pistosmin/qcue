import 'package:cloud_firestore/cloud_firestore.dart';
// import 'quest.dart';

class Quest {
  final String listUid;
  final DocumentReference reference;

  final String listTitle;
  final String listDescription;
  final String creatorName;
  final String creatorUID;

  final String listImageUrl;
  final String listImage;

  final String listCategory;
  final List<String> listTag;

  // final int questNum;
  // final List<Quest> questList;

  final bool isPublic;
  final bool isPeriod;
  final DateTime dateEventStart;
  final DateTime dateEventEnd;
  final DateTime dateCreated;
  final DateTime dateModified;

  Quest.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['listTitle'] != null),
        assert(map['description'] != null),
        assert(map['creator'] != null),

        assert(map['category'] != null),

        assert(map['photoUrl'] != null),
        assert(map['image'] != null),

        listUid = reference.documentID,
        listTitle = map['listTitle'],
        listDescription = map['listDescription'],
        creatorName = map['creatorName'],
        creatorUID = map['creatorUID'],

        listCategory = map['listCategory'],
        listTag = map['listTag'],

        listImageUrl = map['listImageUrl'],
        listImage = map['listImage'],
        
        isPublic = map['listImage'],
        isPeriod = map['listImage'],
        dateEventStart = map['dateEventStart'],
        dateEventEnd = map['dateEventEnd'],
        dateCreated = map['dateCreated'],
        dateModified = map['dateModified'];
        
  Quest.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Quest<$listTitle:$creatorName>";
}
