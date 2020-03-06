import 'package:flutter/material.dart';

class ErrorDialogue extends StatelessWidget {
  final String message;

  const ErrorDialogue(this.message);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text('Error Message'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
  }
}