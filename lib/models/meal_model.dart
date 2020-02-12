class DailyMealRoutine {
  bool morning;
  bool noon;
  bool night;

  DailyMealRoutine({this.morning, this.noon, this.night});

  DailyMealRoutine.fromJson(Map<String, dynamic> data) {
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