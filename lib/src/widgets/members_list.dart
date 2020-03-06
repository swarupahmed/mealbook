import 'package:flutter/material.dart';
import 'package:mealbook/src/models/book_model.dart';
import 'package:mealbook/src/models/monthly_member_model.dart';
import 'package:mealbook/src/pages/member_details_page.dart';
import 'package:mealbook/src/sevices/global_provider.dart';

import 'package:provider/provider.dart';


class MembersList extends StatefulWidget {
  MembersList({Key key}) : super(key: key);
  @override
  _MembersListState createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  //CollectionReference _bookRef = Firestore.instance.collection('Books');

  @override
  Widget build(BuildContext context) {
    var _book = Provider.of<Book>(context);
    var _members = Provider.of<List<MonthlyMember>>(context);
    var _func = Provider.of<Global>(context);
    return (_members != null && _book != null)
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: _members.length,
            itemBuilder: (context, index) {
              var member = _members[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.blueGrey),
                  subtitle: Text(_book.bookId),
                  title: Text(member.name),
                  trailing: Icon(Icons.more_vert),
                  onTap: () => _func.pushPage(
                      context,
                      MemberDetailsPage(
                        member: member,
                        book: _book,
                      )),
                ),
              );
            },
          )
        : CircularProgressIndicator();
  }
}
