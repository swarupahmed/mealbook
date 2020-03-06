import 'package:flutter/material.dart';
import 'package:mealbook/src/models/monthly_member_model.dart';

class MealIcons extends StatefulWidget {
  final DailyMeal routine;
  MealIcons({this.routine});
  @override
  _MealIconsState createState() => _MealIconsState();
}

class _MealIconsState extends State<MealIcons> {
  @override
  Widget build(BuildContext context) {
    Icon iconFilled = Icon(Icons.check_circle);
    Icon iconBlank = Icon(Icons.check_circle_outline);
    var routine =
        widget.routine;

    return Container(
        child: Row(
      children: <Widget>[
        (routine.morning) ? iconFilled : iconBlank,
        routine.noon ? iconFilled : iconBlank,
        routine.night ? iconFilled : iconBlank
      ],
    ));
  }
}
