import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealbook/auth/auth.dart';
import 'package:mealbook/connections/streams.dart';
import 'package:mealbook/models/user_model.dart';
import 'package:mealbook/pages/user/create_admin_page.dart';
import 'package:mealbook/pages/user/join_manager_page.dart';
import 'package:provider/provider.dart';

import 'admin/admin_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context) ?? null;
    return (userData?.activeBook != null)
        ? MultiProvider(
            providers: [
              StreamProvider.value(
                value: joinRequestStream(userData.activeBook.bookId),
              ),
              StreamProvider.value(
                value: bookStream(userData.activeBook.bookId),
              ),
            ],
            child: AdminPage(),
          )
        : UserHome();
  }
}

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Book"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                authService.logout();
              })
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '${user.email}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              FirstButtons(
                buttonName: "Create Manager Panel",
                iconData: Icons.add,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateManager()),
                  );
                },
              ),
              SizedBox(height: 16),
              FirstButtons(
                buttonName: "Join your Manager",
                iconData: Icons.search,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JoinBook()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
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
