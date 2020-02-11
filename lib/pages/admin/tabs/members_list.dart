import 'package:flutter/material.dart';
import 'package:mealbook/models/member_model.dart';


class MemberList extends StatefulWidget {
  final List<Member> members;

  const MemberList({Key key, this.members}) : super(key: key);

  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

