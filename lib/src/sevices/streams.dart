import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealbook/src/models/book_model.dart';
import 'package:mealbook/src/models/member_model.dart';
import 'package:mealbook/src/models/monthly_book.dart';
import 'package:mealbook/src/models/monthly_member_model.dart';
import 'package:mealbook/src/models/user_model.dart';

var date = DateTime.now();
String bookDate = date.month.toString() + '_' + date.year.toString();

Stream<List<Book>> searchBookStream(searchKey) {
  return Firestore.instance
      .collection('Books')
      .where("indexes", arrayContains: searchKey)
      .snapshots()
      .map((qsnap) =>
          qsnap.documents.map((document) => Book.fromSnap(document)).toList());
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

Stream<MonthlyBook> monthlyBookStream(bookId) {
  return Firestore.instance
      .collection('Books')
      .document(bookId)
      .collection('Monthly_Books')
      .document(bookDate)
      .snapshots()
      .map((document) => MonthlyBook.fromSnap(document));
}

// Stream<List<Member>> memberStream(String bookId) {
//   return Firestore.instance
//       .collection('Books')
//       .document(bookId)
//       .collection('Members')
//       .snapshots()
//       .map((qsnap) => qsnap.documents
//           .map((document) => Member.fromSnap(document))
//           .toList());
// }

Stream<List<MonthlyMember>> monthlyMemberStream(String bookId) {
  return Firestore.instance
      .collection('Books')
      .document(bookId)
      .collection('Monthly_Books')
      .document(bookDate)
      .collection('MemberData')
      .snapshots()
      .map((qsnap) => qsnap.documents
          .map((document) => MonthlyMember.fromSnapshot(document))
          .toList());
}

Stream<List<JoinRequest>> joinRequestStream(String bookId) {
  return Firestore.instance
      .collection('Books')
      .document(bookId)
      .collection('Join_Requests')
      .where('request_status', isEqualTo: 'pending')
      .snapshots()
      .map((qsnap) => qsnap.documents
          .map((document) => JoinRequest.fromSnap(document))
          .toList());
}
