import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealbook/models/book_model.dart';
import 'package:mealbook/models/member_model.dart';
import 'package:mealbook/models/user_model.dart';


Stream<List<Book>> searchBookStream(searchKey) {
  return Firestore.instance
      .collection('Books')
      .where("indexes", arrayContains: searchKey)
      .snapshots()
      .map((qsnap) => qsnap.documents
          .map((document) => Book.fromSnap(document))
          .toList());
}

Stream<UserData> userDataStream(String uid) {
  return Firestore.instance
      .collection('User')
      .document(uid)
      .snapshots()
      .map((document) => UserData.fromSnap(document));
}

Stream<Book> bookStream(bookId) {
  return Firestore.instance
      .collection('Books')
      .document(bookId)
      .snapshots()
      .map((document) => Book.fromSnap(document));
}

Stream<List<Member>> memberStream(String bookId) {
  return Firestore.instance
      .collection('Books')
      .document(bookId)
      .collection('Members')
      .snapshots()
      .map((qsnap) => qsnap.documents
          .map((document) => Member.fromSnap(document))
          .toList());
}

Stream<List<JoinRequest>> joinRequestStream(String bookId) {
  return Firestore.instance
      .collection('Books')
      .document(bookId)
      .collection('Join_Requests')
      .where('request_status',isEqualTo: 'pending')
      .snapshots()
      .map((qsnap) => qsnap.documents
          .map((document) => JoinRequest.fromSnap(document))
          .toList());
}


