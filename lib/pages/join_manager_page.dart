import 'package:flutter/material.dart';
import 'package:mealbook/models/book_model.dart';
import 'package:provider/provider.dart';

import '../streams.dart';

class JoinBook extends StatefulWidget {
  @override
  _JoinBookState createState() => _JoinBookState();
}

class _JoinBookState extends State<JoinBook> {
  String searchKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FindBook'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val) => setState(()=>searchKey = val),
            ),
          ),
          //check for all kinds of null
          if (searchKey != "" && searchKey != null)
            StreamProvider<List<Book>>.value(
              value: bookStream(searchKey),
              child: BookList(),
            ),
        ],
      ),
    );
  }
}

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    var books = Provider.of<List<Book>>(context);
    return books == null
        ? CircularProgressIndicator()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: books.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(books[index].name),
              );
            },
          );
  }
}
