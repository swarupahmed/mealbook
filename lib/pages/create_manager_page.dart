import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealbook/models/book_model.dart';
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
  DocumentReference bookRef = Firestore.instance.collection('Books').document();

  final _formKey = GlobalKey<FormState>();
  String _name;
  String _location;
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    DocumentReference userRef =
        Firestore.instance.collection('User').document(user.uid);
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              'Book Information',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20.0),
            TextFormField(
                onSaved: (value) => _name = value,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Book Name")),
            TextFormField(
                onSaved: (value) => _location = value,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Location")),
            SizedBox(
              height: 5,
            ),
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
                      List<String> splitNameList = _name?.split(" ");
                      List<String> splitLocationList = _location.contains(",")
                          ? _location.split(",")
                          : _location.split(" ");

                      List<String> indexedNameList = [];
                      List<String> indexedLocationList = [];

                      for (int i = 0; i < splitNameList.length; i++) {
                        indexedNameList.add(splitNameList[i].toLowerCase());
                        print(indexedNameList);
                      }
                      for (int i = 0; i < splitLocationList.length; i++) {
                        indexedLocationList
                            .add(splitLocationList[i].toLowerCase());
                        print(indexedLocationList);
                      }
                      //create a system in database
                      String _id = bookRef.documentID;
                      setPanel() async {
                        await bookRef.setData(
                          {
                            'name': _name,
                            "location": _location,
                            'bookId': _id,
                            'indexes': indexedNameList,
                            "indexedLocation": indexedLocationList,
                            "createdAt": DateTime.now()
                          },
                        );
                        await bookRef
                            .collection('Managers')
                            .document()
                            .setData({
                          'email': user.email,
                          'joined': DateTime.now(),
                        });
                        await userRef
                            .collection('Active_Books')
                            .document()
                            .setData({'name': _name, 'bookId': _id});
                      }

                      try {
                        setPanel();
                      } on Exception catch (error) {
                        return _buildErrorDialog(context, error.toString());
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookCreatedPage(
                                  book: Book(
                                      name: _name,
                                      location: _location,
                                      bookId: _id))));
                    }
                  },
                ),
              ],
            )
          ]),
        ));
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

class BookCreatedPage extends StatelessWidget {
  final Book book;

  const BookCreatedPage({Key key, this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text( book.name),
      ),
          body: Center(
            child: Column(
        children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('book crated succesfully',style: TextStyle(color: Colors.green[600],fontSize: 16),),
            ),
            Text('book ID: ${book.bookId}',style: TextStyle(fontSize: 16)),
            SizedBox(height: 50,),
            Text(book.name,style: TextStyle(fontSize: 18)),
            Text(book.location,style: TextStyle(fontSize: 16)),
        ],
      ),
          ),
    );
  }
}
