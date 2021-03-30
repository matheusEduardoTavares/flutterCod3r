import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

///Classe que irá centralizar todo e qualquer acesso à parte
///de persistência de dados usando o [shared_preferences]
abstract class Store {
  static SharedPreferences _sharedPreferences;

  static Future<void> initStore() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveString(String key, String value) async {
    _sharedPreferences.setString(key, value);
  }

  static Future<void> saveMap(String key, Map<String, dynamic> value) async {
    await saveString(key, json.encode(value));
  }

  static Future<String> getString(String key) async {
    return _sharedPreferences.getString(key);
  }

  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      Map<String, dynamic> map = json.decode(await getString(key));
      return map;
    }
    catch (_) {
      return null;
    }
  }

  static Future<bool> remove(String key) async {
    return _sharedPreferences.remove(key);
  }
}