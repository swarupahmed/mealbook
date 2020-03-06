import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealbook/src/sevices/auth_service.dart';
import 'package:mealbook/src/sevices/global_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context);
    final global=Provider.of<Global>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page Flutter Firebase"),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Login Information',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Address")),
                  TextFormField(
                      onSaved: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password")),
                  SizedBox(height: 20.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("LOGIN"),
                        onPressed: () async {
                          // save the fields..
                          final form = _formKey.currentState;
                          form.save();

                          // Validate will return true if is valid, or false if invalid.
                          if (form.validate()) {
                            try {
                              FirebaseUser result =
                              await authService.loginUser(
                                  email: _email, password: _password);
                              print(result);
                            } on AuthException catch (error) {
                              return global.buildErrorDialog(context, error.message);
                            } on Exception catch (error) {
                              return global.buildErrorDialog(context, error.toString());
                            }
                          }
                        },
                      ),
                      RaisedButton(
                        child: Text("Register"),
                        onPressed: () async {
                          // save the fields..
                          final form = _formKey.currentState;
                          form.save();

                          // Validate will return true if is valid, or false if invalid.
                          if (form.validate()) {
                            try {
                              FirebaseUser result =
                              await authService.createUser(
                                  _email, _password);
                              print(result);
                            } on AuthException catch (error) {
                              return global.buildErrorDialog(context, error.message);
                            } on Exception catch (error) {
                              return global.buildErrorDialog(context, error.toString());
                            }
                          }
                        },
                      ),
                    ],
                  )
                ]))));
  }


}



