import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealbook/models/book_model.dart';
import 'package:mealbook/pages/widgets/dialogs.dart';
import 'package:provider/provider.dart';

class CreateManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Create Manager Panel'),
      ),
      body: SingleChildScrollView(child: ManagerForm()),
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
  String _name, _location, _description;

  bool roomNoCheck = false;
  bool floorNoCheck = false;
  bool blockNoCheck = false;

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
              decoration: InputDecoration(labelText: "Book Name"),
              validator: (value) => value.isEmpty ? "Enter a Name" : null,
            ),
            TextFormField(
              onSaved: (value) => _location = value,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Location"),
              validator: (value) => value.isEmpty ? "Enter a Location" : null,
            ),
            TextFormField(
              onSaved: (value) => _description = value,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: null,
              decoration: InputDecoration(labelText: "Description.."),
              validator: (value) => value.isEmpty ? "Enter some text" : null,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Text("Boarder Data"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: roomNoCheck,
                            onChanged: (bool value) =>
                                setState(() => roomNoCheck = value)),
                        Text("Room No"),
                      ],
                    ),
                    Checkbox(
                        value: floorNoCheck,
                        onChanged: (bool value) =>
                            setState(() => floorNoCheck = value)),
                    Text("Floor No"),
                    Checkbox(
                        value: blockNoCheck,
                        onChanged: (bool value) =>
                            setState(() => blockNoCheck = value)),
                    Text("Block No"),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    "Create Book",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () async {
                    // save the fields..
                    final form = _formKey.currentState;
                    form.save();

                    if (form.validate()) {
                      List<String> _indexer(List text) {
                        List<String> list = [];
                        for (int i = 0; i < text.length; i++) {
                          list.add(text[i].toLowerCase());
                        }
                        return list;
                      }

                      List<String> splitNameList = _name?.split(" ");
                      List<String> splitLocationList = _location.contains(",")
                          ? _location.split(",")
                          : _location.split(" ");

                      List<String> indexedNameList = _indexer(splitNameList);
                      List<String> indexedLocationList =
                          _indexer(splitLocationList);

                      //create a system in database
                      String _id = bookRef.documentID;
                      setPanel() async {
                        await bookRef.setData(
                          {
                            'name': _name,
                            "location": _location,
                            "description": _description,
                            'bookId': _id,
                            'indexes': indexedNameList,
                            "indexedLocation": indexedLocationList,
                            "createdAt": DateTime.now(),
                            "joining_requirements": {
                              "roomNo": roomNoCheck,
                              "floorNo": floorNoCheck,
                              "blockNo": blockNoCheck
                            }
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
                        return showDialog(
                            builder: (context) =>
                                ErrorDialogue(error.toString()),
                            context: context);
                      }
                      Navigator.pushReplacement(
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
}

class BookCreatedPage extends StatelessWidget {
  final Book book;

  const BookCreatedPage({Key key, this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'book crated succesfully',
                style: TextStyle(color: Colors.green[600], fontSize: 16),
              ),
            ),
            Text('book ID: ${book.bookId}', style: TextStyle(fontSize: 16)),
            SizedBox(
              height: 50,
            ),
            Text(book.name, style: TextStyle(fontSize: 18)),
            Text(book.location, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
