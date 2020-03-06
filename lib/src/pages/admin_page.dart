import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mealbook/src/models/book_model.dart';
import 'package:mealbook/src/models/member_model.dart';
import 'package:mealbook/src/sevices/auth_service.dart';
import 'package:mealbook/src/widgets/admin_grocery.dart';
import 'package:mealbook/src/widgets/admin_home.dart';
import 'package:mealbook/src/widgets/admin_members.dart';
import 'package:mealbook/src/widgets/admin_profile.dart';
import 'package:mealbook/src/widgets/bottom_bar_item.dart';



import 'package:provider/provider.dart';



class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<String> titles;
  var currentTabIndex = 0;
  String currentTitle;

  List<Widget> tabPages;
  Widget currentPage;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    titles = ['Home', 'Members', 'Grocery', 'Profile'];
    tabPages = [
      AdminHomeTab(key: PageStorageKey('home')),
      AdminMemberTab(key: PageStorageKey('member')),
      AdminGroceryTab(key: PageStorageKey('grocery')),
      AdminProfileTab(key: PageStorageKey('profile'))
    ];
    currentPage = tabPages[currentTabIndex];
    currentTitle = titles[currentTabIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var joinRequests = Provider.of<List<JoinRequest>>(context);
    //adminMemberNotification,
    //adminGroceryNotification,
    //adminProfileNitification;
    var authService = Provider.of<AuthService>(context);
    var book = Provider.of<Book>(context);

    List<BottomNavigationBarItem> tabItems = [
      BottomNavigationBarItem(
          title: Text('Home'),
          icon: BottomNavIcon(
            iconData: Icons.home,
          )),
      BottomNavigationBarItem(
          title: Text('Members'),
          icon: BottomNavIcon(
              iconData: Icons.supervised_user_circle,
              notificationList: joinRequests != null ? joinRequests : null)),
      BottomNavigationBarItem(
          title: Text('Grocery'),
          icon: BottomNavIcon(
            iconData: Icons.local_grocery_store,
          )),
      BottomNavigationBarItem(
          title: Text('Profile'),
          icon: BottomNavIcon(
            iconData: Icons.settings,
          )),
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print(book.bookId);
          Map<String, dynamic> data = {
            "name": "memberName",
            "daily_meals": [
              {"morning": false, "noon": true, "night": true},
              {"morning": false, "noon": true, "night": true}
            ],
            "deposits": [
              {"date": "date", "amount": 100},
              {"date": "date", "amount": 100}
            ]
          };
          var date = DateTime.now();
          String bookDate = date.month.toString() + '_' + date.year.toString();
          Firestore.instance
              .collection('Books')
              .document(book.bookId)
              .collection('Monthly_Books')
              .document(bookDate)
              .collection('MemberData')
              .document('k4ZpExIj9m6Sy5c1uJXG')
              .setData(data);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        elevation: 5,
        unselectedIconTheme: IconThemeData(color: Colors.black),
        items: tabItems,
        currentIndex: currentTabIndex,
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
            currentPage = tabPages[index];
            currentTitle = titles[index];
          });
        },
        selectedItemColor: Colors.blue,
      ),
      appBar: AppBar(
        title: Text(currentTitle),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                authService.logout();
              })
        ],
      ),
      body: PageStorage(
        child: currentPage,
        bucket: bucket,
      ),
    );
  }
}

//show a tabbar home for admin
