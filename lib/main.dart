import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealbook/auth/auth.dart';
import 'package:mealbook/auth/login_page.dart';
import 'package:mealbook/connections/streams.dart';
import 'package:mealbook/pages/home_page.dart';
import 'package:mealbook/providers/common_provider.dart';
import 'package:provider/provider.dart';

void main()=> runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged,),
        ChangeNotifierProvider(create:(_)=> AuthService(),),

        Provider(create: (_)=>CommonFunc(),)
    ],
    child: MaterialApp(
      title: 'Meal Book',
      home: Home()
    ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    FirebaseUser user=Provider.of<FirebaseUser>(context);
     if(user!=null){
       return StreamProvider.value(
         value: userDataStream(user.uid),
         child: HomePage());
     }else{
       return LoginPage();}
  
  }
}
