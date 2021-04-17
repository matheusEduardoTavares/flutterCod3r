import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override 
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // ignore: unused_field
  AuthData _authData = AuthData();

  void _handleSubmit(AuthData newAuthData) {
    print('AuthScreen');
    print(newAuthData.name);
    print(newAuthData.email);
    setState(() {
      _authData = newAuthData;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _handleSubmit,
      ),
    );
  }
}