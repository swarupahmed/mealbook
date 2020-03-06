import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'src/pages/home_page.dart';
import 'src/pages/login_page.dart';

import 'src/sevices/auth_service.dart';
import 'src/sevices/global_provider.dart';
import 'src/sevices/streams.dart';

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
        StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged),
        ChangeNotifierProvider<AuthService>(create:(_)=> AuthService(),),
        Provider<Global>(create: (_)=>Global(),)
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
       return LoginPage();
       } 
  }
}
