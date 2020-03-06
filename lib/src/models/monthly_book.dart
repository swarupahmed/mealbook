import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyBook {
  int month;

  MonthlyBook({this.month});

  MonthlyBook.fromSnap(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data;
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    return data;
  }
}
