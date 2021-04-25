import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override 
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  Future<void> _handleSubmit(AuthData newAuthData) async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential _authResult;
      if (newAuthData.isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
          email: newAuthData.email.trim(),
          password: newAuthData.password,
        );
      }
      else {
        _authResult = await _auth.createUserWithEmailAndPassword(
          email: newAuthData.email.trim(),
          password: newAuthData.password,
        );

        final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(_authResult.user.uid + '.jpg');

        await ref.putFile(newAuthData.image).onComplete;
        final url = await ref.getDownloadURL();

        final userData = {
          'name': newAuthData.name,
          'email': newAuthData.email,
          'imageUrl': url,
        };

        await FirebaseFirestore.instance.collection('users')
          .doc(_authResult.user.uid)
          .set(userData);
      }
    } on PlatformException catch (err) {
      final msg = err.message ?? 'Ocorreu um erro! Verifique suas credenciais!'; 
      ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(msg),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      
      setState(() {
        _isLoading = false;
      });
    }
    catch (err) {
      print(err);

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  AuthForm(
                    _handleSubmit
                  ),
                  if (_isLoading)
                    Positioned.fill(
                      child: Container(
                        margin: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5)
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}