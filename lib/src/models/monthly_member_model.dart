import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyMember {
  String name;
  List<DailyMeal> dailyMeals;
  List<Deposit> deposits;

  MonthlyMember({this.name, this.dailyMeals, this.deposits});

  MonthlyMember.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data;
    name = json['name'];
    if (json['daily_meals'] != null) {
      dailyMeals = new List<DailyMeal>();
      json['daily_meals'].forEach((v) {
        dailyMeals.add(new DailyMeal.fromJson(v));
      });
    }
    if (json['deposits'] != null) {
      deposits = new List<Deposit>();
      json['deposits'].forEach((v) {
        deposits.add(new Deposit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.dailyMeals != null) {
      data['daily_meals'] = this.dailyMeals.map((v) => v.toJson()).toList();
    }
    if (this.deposits != null) {
      data['deposits'] = this.deposits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DailyMeal {
  bool morning;
  bool noon;
  bool night;

  DailyMeal({this.morning, this.noon, this.night});

  DailyMeal.fromJson(Map<String, dynamic> json) {
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

class Deposit {
  String date;
  int amount;

  Deposit({this.date, this.amount});

  Deposit.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    return data;
  }
}
