import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mealbook/models/book_model.dart';
import 'package:mealbook/pages/widgets/dialogs.dart';

class BookJoiningPage extends StatefulWidget {
  final String title = "Joining Form";
  final Book book;

  BookJoiningPage({Key key, this.book});
  @override
  _BookJoinPageState createState() => _BookJoinPageState();
}

class _BookJoinPageState extends State<BookJoiningPage> {
  final _formKey = GlobalKey<FormState>();
  String _memberName, _floorNo, _roomNo, _blockNo, _message;
  @override
  Widget build(BuildContext context) {
    DocumentReference _bookRef =
        Firestore.instance.collection('Books').document(widget.book.bookId);
    print(widget.book.joiningRequirements.blockNoCheck);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      'Fill the input form',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      onSaved: (value) => _memberName = value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Member Name"),
                      validator: (value) =>
                          value.isEmpty ? "Enter your Name" : null,
                    ),
                    if (widget.book.joiningRequirements.roomNoCheck)
                      TextFormField(
                        onSaved: (value) => _roomNo = value,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: "Room No"),
                        validator: (value) =>
                            value.isEmpty ? "Room No is required" : null,
                      ),
                    if (widget.book.joiningRequirements.floorNoCheck)
                      TextFormField(
                        onSaved: (value) => _floorNo = value,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: "Floor no"),
                        validator: (value) =>
                            value.isEmpty ? "Floor No is required" : null,
                      ),
                    if (widget.book.joiningRequirements.blockNoCheck)
                      TextFormField(
                        onSaved: (value) => _blockNo = value,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: "Block No"),
                        validator: (value) =>
                            value.isEmpty ? "Block No is required" : null,
                      ),
                    TextFormField(
                      onSaved: (value) => _message = value,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      decoration: InputDecoration(labelText: "Message.."),
                      validator: (value) =>
                          value.isEmpty ? "A message for admin" : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text(
                            "Send Join Request",
                            style: TextStyle(fontSize: 17),
                          ),
                          onPressed: () async {
                            // save the fields..
                            final _form = _formKey.currentState;
                            _form.save();

                            if (_form.validate()) {
                              Map<String, dynamic> data = {
                                "name": _memberName,
                                "member_data": {
                                  if (_roomNo != null) "room_no": _roomNo,
                                  if (_floorNo != null) "floor_no": _floorNo,
                                  if (_blockNo != null) "block_no": _blockNo
                                },
                                if (_roomNo != null)"joining_message": _message,
                                "request_date": DateTime.now(),
                                "request_status":"pending"
                              };
                              joinRequest() {
                                _bookRef.collection('Join_Requests').add(data);
                              }

                              try {
                                joinRequest();
                              } on Exception catch (error) {
                                return showDialog(
                                    builder: (context) =>
                                        ErrorDialogue(error.toString()),
                                    context: context);
                              }

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SubmissionConfirmPage()));
                            }
                          },
                        ),
                      ],
                    )
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}

class SubmissionConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Joinig request sent"),
      ),
    );
  }
}
