import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mealbook/src/models/member_model.dart';
import 'package:mealbook/src/models/user_model.dart';

import 'package:provider/provider.dart';
import 'members_list.dart';

class AdminMemberTab extends StatefulWidget {
  AdminMemberTab({Key key}) : super(key: key);
  @override
  _AdminMemberTabState createState() => _AdminMemberTabState();
}

class _AdminMemberTabState extends State<AdminMemberTab> {
  @override
  Widget build(BuildContext context) {
    var joinRequests = Provider.of<List<JoinRequest>>(context);


    return Column(
      children: <Widget>[
        joinRequests != null
            ? RequestNotifications(
                requests: joinRequests,
              )
            : Container(),
        Text('Members List'),
        //TODO: show list for active month
          // add data to monthly_book & reference to Books/AllMembers/doc
        // Show List for Whole Book
       MembersList()
      ],
    );
  }
}

class RequestNotifications extends StatefulWidget {
  final List<JoinRequest> requests;

  const RequestNotifications({Key key, this.requests}) : super(key: key);
  @override
  _RequestNotificationsState createState() => _RequestNotificationsState();
}

class _RequestNotificationsState extends State<RequestNotifications> {
  CollectionReference _bookRef = Firestore.instance.collection('Books');
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);
    var requests = userData!=null ?widget.requests :null;
    return (requests != null)
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: requests.length,
            itemBuilder: (context, index) {
              var request = requests[index];
              _accept() {
                _bookRef
                    .document(userData.activeBook.bookId)
                    .collection('All_Members')
                    .document(request.id)
                    .setData({
                  'member_id': request.id,
                  'name': request.name,
              
                  'joined_date': FieldValue.serverTimestamp()
                });
                _bookRef
                    .document(userData.activeBook.bookId)
                    .collection('Join_Requests')
                    .document(request.id)
                    .updateData({'request_status': 'accepted'});
              }

              _delete() {
                _bookRef
                    .document(userData.activeBook.bookId)
                    .collection('Join_Requests')
                    .document(request.id)
                    .updateData({'request_status': 'deleted'});
              }

           
                
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          request.name,
                          style: TextStyle(fontSize: 18),
                        ),
                    
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          child: Text('accept', style: TextStyle(fontSize: 16)),
                          onTap: () => _accept(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => _delete(),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          )
        : Container();
  }
}

