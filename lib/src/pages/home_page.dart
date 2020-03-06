import 'package:flutter/material.dart';
import 'package:mealbook/src/models/book_model.dart';
import 'package:mealbook/src/models/member_model.dart';
import 'package:mealbook/src/models/monthly_book.dart';
import 'package:mealbook/src/models/monthly_member_model.dart';
import 'package:mealbook/src/models/user_model.dart';
import 'package:mealbook/src/sevices/streams.dart';

import 'package:provider/provider.dart';

import 'admin_page.dart';
import 'member_page.dart';
import 'user_home_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);
    var activeBook = userData?.activeBook;
    var bookId = activeBook?.bookId;
    return (activeBook != null)
        ? MultiProvider(
            providers: [
              // StreamProvider<List<Member>>.value(
              //   value: memberStream(activebook.bookId),
              // ),
              StreamProvider<List<MonthlyMember>>.value(
                value: monthlyMemberStream(bookId),
                catchError: (_, err) {
                  print(err.toString());
                  return List<MonthlyMember>();
                },
              ),
            ],
            child: activeBook.adminStatus
                ? MultiProvider(
                    providers: [
                      StreamProvider<List<JoinRequest>>.value(
                        value: joinRequestStream(bookId),
                      ),
                      StreamProvider<Book>.value(
                        value: bookStream(bookId),
                      ),
                      StreamProvider<MonthlyBook>.value(
                        value: monthlyBookStream(bookId),
                      ),
                    ],
                    child: AdminPage(),
                  )
                : MemberPage(),
          )
        : UserHomePage();
  }
}

class FirstButtons extends StatelessWidget {
  final String buttonName;
  final IconData iconData;
  final Function onPressed;

  const FirstButtons(
      {@required this.buttonName,
      @required this.iconData,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: Material(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(buttonName,
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
              IconButton(
                icon: Icon(iconData, size: 32),
                onPressed: onPressed,
              ),
            ],
          )),
    );
  }
}
