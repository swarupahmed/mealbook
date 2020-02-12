import 'package:flutter/material.dart';
import 'package:mealbook/models/book_model.dart';
import 'package:mealbook/models/meal_model.dart';
import 'package:mealbook/models/member_model.dart';
import 'package:provider/provider.dart';

class MemberDetailsPage extends StatefulWidget {
  final Member member;
  final String title = 'Member Details';

  const MemberDetailsPage({Key key, this.member}) : super(key: key);
  @override
  _MemberDetailsPageState createState() => _MemberDetailsPageState();
}

class _MemberDetailsPageState extends State<MemberDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var _member = widget.member;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
                child: CircleAvatar(
                  radius: 47,
                  backgroundColor: Colors.white70,
                )),
            SizedBox(height: 12),
            Text(_member.name, style: TextStyle(fontSize: 20)),
            SizedBox(height: 12),
            MealStatus()
          ],
        ),
      ),
    );
  }
}

class MealStatus extends StatefulWidget {
  @override
  _MealStatusState createState() => _MealStatusState();
}

class _MealStatusState extends State<MealStatus> {
  @override
  Widget build(BuildContext context) {
    var book = Provider.of<Book>(context);
    var mealRoutine = book?.mealRoutine;

    bool todayRoutineEditMode = false;

    TextStyle _statusStyle = TextStyle(fontSize: 18);
    
    DailyMealRoutine dailyRoutine=DailyMealRoutine(morning: false,
    noon: true,night: false);
    Icon icon = dailyRoutine.noon? Icon(Icons.check_circle):Icon(Icons.check_circle_outline);

    void togglemeal() {}
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: mealRoutine != null
            ? Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Meal Status', style: TextStyle(fontSize: 16)),
                  Divider(),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Text('Today', style: _statusStyle),
                    ],
                  )),
                  SizedBox(height: 5),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Text('Tomorrow', style: _statusStyle),
                      Row(
                        children: <Widget>[
                          if (mealRoutine.morning)
                            todayRoutineEditMode
                                ? IconButton(
                                    icon: icon,
                                    onPressed: () => togglemeal(),
                                  )
                                : icon,
                          if (mealRoutine.noon)
                            todayRoutineEditMode
                                ? IconButton(
                                    icon: icon,
                                    onPressed: () => togglemeal(),
                                  )
                                : icon,
                          if (mealRoutine.night)
                            todayRoutineEditMode
                                ? IconButton(
                                    icon: icon,
                                    onPressed: () => togglemeal(),
                                  )
                                : icon,

                        ],
                      ),
                      IconButton(icon: Icon(Icons.edit), 
                      onPressed: (){
                        setState(() {
                          todayRoutineEditMode=!todayRoutineEditMode;
                        });
                      }
                      )
                    ],
                  )),
                ],
              )
            : ListTile(
                title: Text('Add a Meal Routine'),
                trailing: IconButton(icon: Icon(Icons.add), onPressed: null),
              ),
      ),
    );
  }
}
