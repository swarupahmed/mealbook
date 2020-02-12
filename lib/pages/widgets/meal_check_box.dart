import 'package:flutter/material.dart';
import 'package:mealbook/models/book_model.dart';

class MealCheckBox extends StatefulWidget {
  final MealRoutine mealRoutine;
  final void Function(bool) onChangedMorning;
  final void Function(bool) onChangedNoon;
  final void Function(bool) onChangedNight;

  const MealCheckBox({Key key, this.mealRoutine, this.onChangedMorning, this.onChangedNoon, this.onChangedNight}) : super(key: key);

  @override
  _MealCheckBoxState createState() => _MealCheckBoxState();
}

class _MealCheckBoxState extends State<MealCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          
          Row(
            children: <Widget>[
              Checkbox(value: widget.mealRoutine.morning, onChanged: widget.onChangedMorning),
              Text('Morning'),
            ],
          ),
          
          Row(
            children: <Widget>[
              Checkbox(value: widget.mealRoutine.noon, onChanged:widget.onChangedNoon),
              Text('Noon'),
            ],
          ),
          
          Row(
            children: <Widget>[
              Checkbox(value: widget.mealRoutine.night, onChanged: widget.onChangedNight),
              Text('Night'),
            ],
          ),
          
        ],
      ),
    );
  }
}