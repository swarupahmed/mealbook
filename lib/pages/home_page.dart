import 'package:flutter/material.dart';
import 'package:mealbook/auth/auth.dart';
import 'package:mealbook/pages/create_manager_page.dart';
import 'package:mealbook/pages/join_manager_page.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

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
            children: <Widget>[
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

class SecondRoute {
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
