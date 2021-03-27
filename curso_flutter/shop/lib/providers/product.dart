import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/application/application.dart';
import 'dart:convert';
import 'package:shop/exceptions/http_exception.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false
  });

  void _changeFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite([bool isRethrowException = true]) async {
    _changeFavorite();

    try {
      final response = await http.patch(
        '${Application.productsUrl}/$id.json',
        body: json.encode({
          'isFavorite': isFavorite
        })
      );

      if (response.statusCode >= 400) {
        throw HttpException('Ocorreu um erro na atualização do favorito do produto "$title"');
      }
    }
    catch (e) {
      _changeFavorite();

      if (isRethrowException ?? false) {
        rethrow;
      }
    }
  }
}