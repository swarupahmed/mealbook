import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealbook/models/book_model.dart';
import 'package:mealbook/pages/admin/admin_page.dart';
import 'package:mealbook/pages/widgets/dialogs.dart';
import 'package:mealbook/pages/widgets/meal_check_box.dart';
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
  Firestore ref = Firestore.instance;

  final _formKey = GlobalKey<FormState>();
  String _name, _location, _description;


  MealRoutine _mealRoutine=MealRoutine(morning:false,noon:false,night:false);

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Daily Meal', style: TextStyle(fontSize: 16)),
                MealCheckBox(
                  mealRoutine: _mealRoutine,
                  onChangedMorning: (val) {
                    setState(() {
                      _mealRoutine.morning = val;
                    });
                  },
                  onChangedNoon: (val) {
                    setState(() {
                      _mealRoutine.noon = val;
                    });
                  },
                  onChangedNight: (val) {
                    setState(() {
                      _mealRoutine.night = val;
                    });
                  },
                ),
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
                      DocumentReference bookRef =
                          ref.collection('Books').document();
                      DocumentReference userRef =
                          ref.collection('User').document(user.uid);
                      String _id = bookRef.documentID;
                      setPanel() async {
                        await bookRef.setData(
                          {
                            'bookId': _id,
                            'name': _name,
                            "location": _location,
                            "description": _description,
                            "meal_routine": _mealRoutine.toJson(),
                            'indexes': indexedNameList,
                            "indexedLocation": indexedLocationList,
                            "createdAt": DateTime.now(),
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
                            .collection('User_Books')
                            .document()
                            .setData(
                                {'name': _name, 'bookId': _id, 'admin': true});
                        await userRef.updateData({
                          "active_book": {
                            'book_id': _id,
                            'admin_status': true,
                          },
                        });
                      }

                      try {
                        setPanel();
                      } on Exception catch (error) {
                        return showDialog(
                            builder: (context) =>
                                ErrorDialogue(error.toString()),
                            context: context);
                      }
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => AdminPage()));
                    }
                  },
                ),
              ],
            )
          ]),
        ));
  }
}

class BookProfilePage extends StatelessWidget {
  final Book book;

  const BookProfilePage({Key key, this.book});
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
