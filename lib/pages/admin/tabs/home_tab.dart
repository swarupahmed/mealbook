import 'package:flutter/material.dart';
import 'package:mealbook/models/user_model.dart';
import 'package:provider/provider.dart';

class AdminHomeTab extends StatefulWidget { 
  final String title='Home';

  const AdminHomeTab({Key key}) : super(key: key);
  @override
  _AdminHomeTabState createState() => _AdminHomeTabState();
}

class _AdminHomeTabState extends State<AdminHomeTab> {
  
  @override
  Widget build(BuildContext context) {
    var userData=Provider.of<UserData>(context);
    return Column(
      children: <Widget>[
        Text('Admin Home Tab'),
        Text(userData.email),
      ],
    );
  }
}