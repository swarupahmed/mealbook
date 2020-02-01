import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JoinManager extends StatefulWidget {
  @override
  _JoinManagerState createState() => _JoinManagerState();
}

class _JoinManagerState extends State<JoinManager> {
  String searchKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('find manager'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val) => setState(() {
                searchKey = val;
                print(searchKey);
              }),
            ),
          ),
          if(searchKey != "" && searchKey != null)
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: 
                  Firestore.instance
                      .collection('Books')
                      .where("indexes", arrayContains: searchKey)
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new ListTile(

                          title: new Text(document['name']),
                          subtitle: new Text(document['bookId']),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}

