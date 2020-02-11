import 'package:flutter/material.dart';

class BottomNavIcon extends StatefulWidget {
  final List notificationList;
  final IconData iconData;
  final VoidCallback onPressed;

  BottomNavIcon({Key key, this.iconData, this.onPressed, this.notificationList})
      : super(key: key);
  @override
  _BottomBarItemState createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<BottomNavIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      new Icon(
        widget.iconData,
      ),
      new Positioned(
          top: 0,
          right: 0,
          child: widget.notificationList == null || widget.notificationList.isEmpty
              ?Container(): Icon(Icons.brightness_1, size: 12.0, color: Colors.red[800])
              ),
    ]);
  }
}
