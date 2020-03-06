import 'package:flutter/material.dart';
import 'package:mealbook/src/models/book_model.dart';
import 'package:mealbook/src/models/user_model.dart';
import 'package:provider/provider.dart';

class AdminHomeTab extends StatefulWidget {
  final String title = 'Home';

  const AdminHomeTab({Key key}) : super(key: key);
  @override
  _AdminHomeTabState createState() => _AdminHomeTabState();
}

class _AdminHomeTabState extends State<AdminHomeTab> {
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);
    var _textTheme = Theme.of(context).textTheme;
    //var monthlyBook = Provider.of<MonthlyBook>(context);
    var allMonthlyBooks = Provider.of<Book>(context)?.allMonthlyBooks;
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            userData.email,
            style: _textTheme.headline,
          ),
          //TODO: Build DashBoard
          // -show for active month
          // -create book for new month
          // -no book? create one 
          (allMonthlyBooks == null) ?_AddMonthlyBook():
              Text('month : '+ allMonthlyBooks.last.toString())
        ],
      ),
    );
  }
}

class _AddMonthlyBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    String bookDate = date.month.toString() + '_' + date.year.toString();

    return Container(
      child: Row(
        children: <Widget>[
          Text('Create a Book for $bookDate'),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //add book to monthly_Book
              })
        ],
      ),
    );
  }
}
