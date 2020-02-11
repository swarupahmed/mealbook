import 'package:flutter/material.dart';
import 'package:mealbook/models/book_model.dart';
import 'package:mealbook/pages/user/book_joining_page.dart';

class BookDetailsPage extends StatefulWidget {
  final Book book;
  
  const BookDetailsPage({Key key, this.book});

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join book'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    widget.book.name,
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    widget.book.location,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.book.description,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(right:12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                        onPressed: null,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "More Info",
                              style: TextStyle(fontSize: 22),
                            ),
                            Icon(Icons.arrow_forward)
                          ],
                        )),

                    
                    RaisedButton(
                      color: Colors.black54,
                      highlightColor: Colors.green,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookJoiningPage(book:widget.book)));
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        child: Center(
                          child: Text('Join',
                              style:
                                  TextStyle(fontSize: 23, color: Colors.white70)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

