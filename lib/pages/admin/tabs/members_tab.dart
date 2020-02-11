import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mealbook/models/member_model.dart';

import 'package:mealbook/models/user_model.dart';
import 'package:provider/provider.dart';


class AdminMemberTab extends StatefulWidget {
  const AdminMemberTab({Key key}) : super(key: key);
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
            : null,
        Text('Members List'),
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
    var requests = widget.requests;
    return (requests != null)
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: requests.length,
            itemBuilder: (context, index) {
              var request = requests[index];
              _accept() {
                _bookRef
                    .document(userData.activeBook.bookId)
                    .collection('Members')
                    .document(request.id)
                    .setData({
                  'member_id': request.id,
                  'name': request.name,
                  'member_Data': {
                    if (request.memberData.roomNo != null)
                      'room_no': request.memberData.roomNo,
                    if (request.memberData.roomNo != null)
                      'floor_no': request.memberData.floorNo,
                    if (request.memberData.roomNo != null)
                      'block_no': request.memberData.blockNo,
                  },
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

              String roomData = request.memberData.roomNo != null
                  ? 'room:${request.memberData.roomNo}'
                  : '';
              String floorData = request.memberData.floorNo != null
                  ? 'room:${request.memberData.roomNo}'
                  : '';
              String blockData = request.memberData.blockNo != null
                  ? 'room:${request.memberData.roomNo}'
                  : '';
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
                        Text(roomData + floorData + blockData,
                            style: TextStyle(fontSize: 14)),
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
