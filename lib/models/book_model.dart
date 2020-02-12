import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String name;
  String location;
  String bookId;
  String createdAt;
  String description;
  MealRoutine mealRoutine;

  Book(
      {this.name,
      this.bookId,
      this.description,
      this.location,
      this.createdAt,
      this.mealRoutine});

  Book.fromSnap(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data;
    name = data['name'].toString();
    bookId = data['bookId'].toString();
    description = data['description'].toString();
    location = data['location'].toString();
    createdAt = data['createdAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bookId'] = this.bookId;
    return data;
  }
}

class MealRoutine {
  bool morning;
  bool noon;
  bool night;

  MealRoutine({this.morning, this.noon, this.night});

  MealRoutine.fromJson(Map<String, dynamic> data) {
    morning = data['morning'];
    noon = data['noon'];
    night = data['night'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['morning']=this.morning;
    data['noon']=this.noon;
    data['night']=this.night;
    return data;
  }
}

class JoiningRequirements {
  bool roomNoCheck;
  bool floorNoCheck;
  bool blockNoCheck;

  JoiningRequirements(this.floorNoCheck, this.roomNoCheck, this.blockNoCheck);
}
