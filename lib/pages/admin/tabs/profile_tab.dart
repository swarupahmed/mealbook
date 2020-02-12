import 'package:flutter/material.dart';
import 'package:mealbook/providers/common_provider.dart';
import 'package:provider/provider.dart';

import '../../user_home_page.dart';

class AdminProfileTab extends StatefulWidget {
  AdminProfileTab({Key key}) : super(key: key);
  @override
  _AdminProfileTabState createState() => _AdminProfileTabState();
}

class _AdminProfileTabState extends State<AdminProfileTab> {
  @override
  Widget build(BuildContext context) {
    var _func = Provider.of<CommonFunc>(context);
    return Center(
      child: Column(
        children: <Widget>[
          Text('Admin Profile Tab'),
          MaterialButton(
            color: Colors.grey,
            
              onPressed: () => _func.pushPage(context, UserHomePage()),
              child: Text(
                'Create / Join a Book',
                style: TextStyle(fontSize: 18),
              ))
        ],
      ),
    );
  }
}
