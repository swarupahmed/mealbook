
import 'package:flutter/material.dart';

import 'package:mealbook/connections/streams.dart';
import 'package:mealbook/models/user_model.dart';

import 'package:provider/provider.dart';

import 'admin/admin_page.dart';
import 'member/member_page.dart';
import 'user_home_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context) ?? null;
    return (userData?.activeBook != null)
        ? MultiProvider(
            providers: [
              StreamProvider.value(
                value: bookStream(userData.activeBook.bookId),
              ),
              StreamProvider.value(
                value: memberStream(userData.activeBook.bookId),
              ),
            ],
            child: userData.activeBook.adminStatus
                ? MultiProvider(
                    providers: [
                      StreamProvider.value(
                        value: joinRequestStream(userData.activeBook.bookId),
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
