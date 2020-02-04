import 'package:flutter/material.dart';
import 'package:mealbook/models/book_model.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  const BookDetailsPage({Key key, this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join book'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              book.name,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              book.location,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color: Colors.black54,
              highlightColor:Colors.green ,
              onPressed: (){},
              child: Text('Join',
                  style: TextStyle(fontSize: 20, color: Colors.white70)),
            ),
            ///
            /// joining fields floor,block,room,custom,others :checkboxes
          ],
        ),
      ),
    );
  }
}
