import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String id;
  String email;
  String joined;
  ActiveBook activeBook;

  UserData({
    this.id,
    this.email,
    this.joined,
    this.activeBook,
  });

  UserData.fromSnap(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data;
    id = document.documentID;
    email = data['email'].toString();
    joined = data['joined'].toString();
    (data['active_book'] != null)
        ? activeBook = ActiveBook(
            data['active_book']['book_id'], data['active_book']['admin_status'])
        : activeBook = null;
  }
}

class ActiveBook {
  String bookId;
  bool adminStatus;

  ActiveBook(this.bookId, this.adminStatus);
}


