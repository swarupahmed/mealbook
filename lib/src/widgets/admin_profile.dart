import 'package:flutter/material.dart';
import 'package:mealbook/src/pages/user_home_page.dart';
import 'package:mealbook/src/sevices/global_provider.dart';
import 'package:provider/provider.dart';


class AdminProfileTab extends StatefulWidget {
  AdminProfileTab({Key key}) : super(key: key);
  @override
  _AdminProfileTabState createState() => _AdminProfileTabState();
}

class _AdminProfileTabState extends State<AdminProfileTab> {
  @override
  Widget build(BuildContext context) {
    var global = Provider.of<Global>(context);
    return Center(
      child: Column(
        children: <Widget>[
          Text('Admin Profile Tab'),
          MaterialButton(
            color: Colors.grey,
            
              onPressed: () => global.pushPage(context, UserHomePage()),
              child: Text(
                'Create / Join a Book',
                style: TextStyle(fontSize: 18),
              ))
        ],
      ),
    );
  }
}
