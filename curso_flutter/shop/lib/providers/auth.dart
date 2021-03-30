import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shop/data/store.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/url_firebase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  Timer _logoutTimer;
  String _userId;
  String _token;
  DateTime _expiryDate;
  bool get isAuth => token != null;

  String get userId {
    return isAuth ? _userId : null;
  }

  String get token {
    if (_token != null && _expiryDate != null && _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    
    return null;
  }

  Future<void> _authenticate(
    String email, String password, String urlSegment
  ) async {
    final url = UrlFirebase.getUrl(urlSegment);

    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      })
    );

    final responseBody = json.decode(response.body);

    if (responseBody['error'] != null) {
      throw AuthException(responseBody['error']['message']);
    }

    _token = responseBody['idToken'];
    _userId = responseBody['localId'];
    _expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(responseBody['expiresIn']),
      )
    );

    Store.saveMap('userData', {
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
    });

    _autoLogout();
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) {
      return Future.value();
    }

    final userData = await Store.getMap('userData');
    if (userData == null) {
      return Future.value();
    }

    final expiryDate = DateTime.parse(userData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return Future.value();
    }

    _userId = userData['userId'];
    _token = userData['token'];
    _expiryDate = expiryDate;

    _autoLogout();

    notifyListeners();

    return Future.value();
  }

  Future logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;

    if (_logoutTimer != null) {
      _logoutTimer.cancel();
      _logoutTimer = null;
    }

    await Store.remove('userData');

    notifyListeners();
  }

  void _autoLogout() {
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
    }
    
    final timeToLogout = _expiryDate.difference(DateTime.now()).inSeconds;
    
    _logoutTimer = Timer(
      Duration(
        seconds: timeToLogout,
      ),
      logout
    );
  }
}