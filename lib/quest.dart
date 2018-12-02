import 'package:cloud_firestore/cloud_firestore.dart';
// import 'quest.dart';

class Quest {
  final String questUid;
  final DocumentReference reference;

  final String questTitle;
  final String questDescription;
  final String creatorName;
  final String creatorUID;

  final String questImageUrl;
  final String questImage;

  final String questLocation;
  final String questCategory;
  final List<String> questTag;

  // final int questNum;
  // final List<Quest> questList;

  final bool isPublic;
  final bool hasPeriod;
  final DateTime dateEventStart;
  final DateTime dateEventEnd;
  final DateTime dateCreated;
  final DateTime dateModified;

  Quest.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['questTitle'] != null),
        assert(map['questDescription'] != null),
        assert(map['creatorUID'] != null),

        // assert(map['category'] != null),

        // assert(map['photoUrl'] != null),
        // assert(map['image'] != null),

        questUid = reference.documentID,
        questTitle = map['questTitle'],
        questDescription = map['questDescription'],
        creatorName = map['creatorName'],
        creatorUID = map['creatorUID'],

        questImageUrl = map['questImageUrl'],
        questImage = map['questImage'],

        questLocation = map['questLocation'],
        questCategory = map['questCategory'],
        questTag = map['questTag'],

        isPublic = map['isPublic'],
        hasPeriod = map['hasPeriod'],
        dateEventStart = map['dateEventStart'],
        dateEventEnd = map['dateEventEnd'],
        dateCreated = map['dateCreated'],
        dateModified = map['dateModified'];
        
  Quest.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Quest<$questTitle:$creatorName>";
}
