import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class CreateManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Create Manager Panel'),
      ),
      body: ManagerForm(),
    );
  }
}

class ManagerForm extends StatefulWidget {
  @override
  _ManagerFormState createState() => _ManagerFormState();
}

class _ManagerFormState extends State<ManagerForm> {
  DocumentReference ref = Firestore.instance.collection('Books').document();

  final _formKey = GlobalKey<FormState>();
  String _name;
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            'Login Information',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20.0),
          TextFormField(
              onSaved: (value) => _name = value,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Name")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Submit"),
                onPressed: () async {
                  // save the fields..
                  final form = _formKey.currentState;
                  form.save();

                  // Validate will return true if is valid, or false if invalid.
                  if (form.validate()) {
                     //create a system in database
                      String _id = ref.documentID;
                      setPanel() {
                        ref.setData(
                          {
                            'name': _name,
                            'bookId': _id,
                          },
                        );
                        ref.collection('Managers').document().setData({
                          'email': user.email,
                          'joined': DateTime.now(),
                        });
                      }
                    try {
                     setPanel();
                    } on Exception catch (error) {
                      return _buildErrorDialog(context, error.toString());
                    }
                  }
                },
              ),
            ],
          )
        ]));
  }

  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
