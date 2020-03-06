import 'package:flutter/material.dart';
import 'package:mealbook/src/models/book_model.dart';
import 'package:mealbook/src/models/monthly_member_model.dart';


class MemberDetailsPage extends StatefulWidget {
  final MonthlyMember member;
  final Book book;
  final String title = 'Member Details';

  const MemberDetailsPage({Key key, this.member, this.book}) : super(key: key);
  @override
  _MemberDetailsPageState createState() => _MemberDetailsPageState();
}

class _MemberDetailsPageState extends State<MemberDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var _book = widget.book;
    var _member = widget.member;
    print(_member.dailyMeals);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
                child: CircleAvatar(
                  radius: 47,
                  backgroundColor: Colors.white70,
                )),
            SizedBox(height: 12),
            Text(_member.name, style: TextStyle(fontSize: 20)),
            Text('BookId:${_book.bookId}'),
            SizedBox(height: 12),
            
          ],
        ),
      ),
    );
  }
}

