import 'package:flutter/material.dart';
import 'package:shop/utils/url_firebase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  Future<void> _authenticate(
    String email, String password, String urlSegment
  ) async {
    ///A url para criação de um usuário será uma URL diferente
    ///da usada para trabalhar com o realtime database do 
    ///firebase
    final url = UrlFirebase.getUrl(urlSegment);

    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      })
    );

    ///O token do firebase tem a data de validade de 1 hora.
    print(json.decode(response.body));
    
    ///É opcional deixar ou não:
    // return Future.value();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}