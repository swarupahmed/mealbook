import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String name;
  String bookId;
  String description;
  String location;
  Timestamp createdAt;
  MealRoutine mealRoutine;
  List allMonthlyBooks;

  Book(
      {this.name,
      this.bookId,
      this.description,
      this.location,
      this.createdAt,
      this.mealRoutine,
      this.allMonthlyBooks});

  Book.fromSnap(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data;
    name = json['name'];
    bookId = doc.documentID;
    description = json['description'];
    location = json['location'];
    createdAt = json['createdAt'];
    mealRoutine = json['meal_routine'] != null
        ? new MealRoutine.fromJson(json['meal_routine'])
        : null;
    allMonthlyBooks = json['all_monthly_books'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bookId'] = this.bookId;
    data['description'] = this.description;
    data['location'] = this.location;
    data['createdAt'] = this.createdAt;
    if (this.mealRoutine != null) {
      data['meal_routine'] = this.mealRoutine.toJson();
    }
    return data;
  }
}

class MealRoutine {
  bool morning;
  bool noon;
  bool night;

  MealRoutine({this.morning, this.noon, this.night});

  MealRoutine.fromJson(Map<String, dynamic> json) {
    morning = json['morning'];
    noon = json['noon'];
    night = json['night'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['morning'] = this.morning;
    data['noon'] = this.noon;
    data['night'] = this.night;
    return data;
  }
}

class JoiningRequirements {
  bool roomNoCheck;
  bool floorNoCheck;
  bool blockNoCheck;

  JoiningRequirements(this.floorNoCheck, this.roomNoCheck, this.blockNoCheck);
}
