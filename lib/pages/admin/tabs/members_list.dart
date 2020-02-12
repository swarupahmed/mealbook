import 'package:flutter/material.dart';
import 'package:mealbook/models/member_model.dart';
import 'package:mealbook/providers/common_provider.dart';
import 'package:provider/provider.dart';

import '../member_details_page.dart';


class MembersList extends StatefulWidget {
  final String bookId;
 MembersList({Key key, this.bookId}) : super(key: key);
  @override
  _MembersListState createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  //CollectionReference _bookRef = Firestore.instance.collection('Books');

  @override
  Widget build(BuildContext context) {
var members=Provider.of<List<Member>>(context);
var _func=Provider.of<CommonFunc>(context);
    return members!=null?ListView.builder(
                shrinkWrap: true,
                itemCount: members.length,
                itemBuilder: (context, index) {
                  var member = members[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.blueGrey),
                      title: Text(member.name),
                      trailing: Icon(Icons.more_vert),
                      onTap: ()=>_func.pushPage(context,MemberDetailsPage(member: member,)),
                    ),

                  );
                },
              ):CircularProgressIndicator();
        
  }
}

