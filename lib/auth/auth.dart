import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// return the Future with firebase user object FirebaseUser if one exists
  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  // wrapping the firebase calls
  Future logout() async {
    var result = _auth.signOut();
    notifyListeners();
    return result;
  }

  // wrapping the firebase calls
   Future createUser(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  ///
  /// wrapping the firebase call to signInWithEmailAndPassword
  /// `email` String
  /// `password` String
  ///
  Future<FirebaseUser> loginUser({String email, String password}) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // since something changed, let's notify the listeners...
      notifyListeners();
      return result.user;
    }  catch (e) {
      throw new AuthException(e.code, e.message);
    }
  }
}