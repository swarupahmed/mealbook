import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  String memberId;
  String name;
  Timestamp joinedDate;
  MemberData memberData;

  Member(this.memberId, this.name, this.joinedDate, this.memberData);

  Member.fromSnap(DocumentSnapshot document){
    Map<String, dynamic> data=document.data;
    memberId=document.documentID;
    name=data['name'];
    joinedDate=data['joined_date'];
    memberData=MemberData(
        roomNo: data['member_data']['room_no'],
        floorNo: data['member_data']['floor_no'],
        blockNo: data['member_data']['block_no']);
  }
  }

class JoinRequest {
  String id;
  String name;
  Timestamp requestDate;
  MemberData memberData;

  JoinRequest({this.id,this.name, this.requestDate, this.memberData});

  JoinRequest.fromSnap(DocumentSnapshot document) {
    Map<String, dynamic> data=document.data;
    id=document.documentID;
    name = data['name'].toString();
    requestDate = data['request_data'];
    memberData = MemberData(
        roomNo: data['member_data']['room_no']??'',
        floorNo: data['member_data']['floor_no']??'',
        blockNo: data['member_data']['block_no']??'');
  }
}

class MemberData {
  String roomNo;
  String floorNo;
  String blockNo;

  MemberData({this.roomNo, this.floorNo, this.blockNo});
}