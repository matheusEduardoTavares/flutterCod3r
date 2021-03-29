import 'package:flutter/material.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/url_firebase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _userId;
  String _token;
  DateTime _expiryDate;
  ///Getter que retornar se o getter do [token] é valido, ou seja
  ///se o usuário está logado corretamente dentro da data válida
  bool get isAuth => token != null;

  String get userId {
    return isAuth ? _userId : null;
  }

  String get token {
    ///Se há token, há data de expiração do token e essa data não
    ///expirou ainda retornamos o token se não retornamos nulo.
    if (_token != null && _expiryDate != null && _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    
    return null;
  }

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
    final responseBody = json.decode(response.body);

    if (responseBody['error'] != null) {
      throw AuthException(responseBody['error']['message']);
    }

    _token = responseBody['idToken'];
    ///O [localId] é o UUID do usuário que fez o login.
    _userId = responseBody['localId'];
    _expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(responseBody['expiresIn']),
      )
    );

    notifyListeners();
    ///É opcional deixar ou não:
    // return Future.value();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;

    notifyListeners();
  }
}