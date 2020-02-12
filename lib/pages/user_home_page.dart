import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealbook/auth/auth.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'user/create_admin_page.dart';
import 'user/join_manager_page.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
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