import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  String id;
  String name;
  Timestamp joinDate;


  Member({this.id,this.name, this.joinDate});

  Member.fromSnap(DocumentSnapshot document) {
    Map<String, dynamic> data=document.data;
    id=document.documentID;
    name = data['name'].toString();
    joinDate = data['joined_date'];

  }
}


class JoinRequest {
  String id;
  String name;
  Timestamp requestDate;

  JoinRequest({this.id,this.name, this.requestDate});

  JoinRequest.fromSnap(DocumentSnapshot document) {
    Map<String, dynamic> data=document.data;
    id=document.documentID;
    name = data['name'].toString();
    requestDate = data['request_date'];

  }
}

// class MemberData {
//   String roomNo;
//   String floorNo;
//   String blockNo;

//   MemberData({this.roomNo, this.floorNo, this.blockNo});
// }