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

  Map<String, dynamic> toMap({
    bool hasId = true,
    bool hasTitle = true,
    bool hasDescription = true,
    bool hasPrice = true,
    bool hasImageUrl = true,
    bool hasFavorite = true,
  }) {
    return {
      if (hasId)
        'id': id,
      if (hasTitle)
        'title': title,
      if (hasDescription)
        'description': description,
      if (hasPrice)
        'price': price,
      if (hasImageUrl)
        'imageUrl': imageUrl,
      if (hasFavorite)
        'isFavorite': isFavorite,
    };
  }

  factory Product.fromJson(String jsonData) {
    if (jsonData == null) return null;
    final Map<String, dynamic> map = json.decode(jsonData);

    if (map == null) return null;

    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      isFavorite: map['isFavorite'],
    );
  }

  String toJson({
    bool hasId = true,
    bool hasTitle = true,
    bool hasDescription = true,
    bool hasPrice = true,
    bool hasImageUrl = true,
    bool hasFavorite = true,
  }) => json.encode(toMap(
    hasId: hasId,
    hasTitle: hasTitle,
    hasDescription: hasDescription,
    hasPrice: hasPrice,
    hasImageUrl: hasImageUrl,
    hasFavorite: hasFavorite,
  ));

  Product copyWith({
    final String id,
    final String title,
    final String description,
    final double price,
    final String imageUrl,
    bool isFavorite
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  void _changeFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, [bool isRethrowException = true]) async {
    _changeFavorite();

    try {
      final response = await http.patch(
        '${Application.productsUrl}/$id.json?auth=$token',
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