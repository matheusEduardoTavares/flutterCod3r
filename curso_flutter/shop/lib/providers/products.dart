import 'package:flutter/material.dart';
import 'package:shop/application/application.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [];
  String _token;

  Products(this._token, this._items);

  List<Product> get items => List.from(_items);

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> addProduct(Product newProduct) async {
    final response = await http.post(
      '${Application.productsUrl}.json',
      body: newProduct.toJson(
        hasId: false,
      ),
    );

    _items.add(
      newProduct.copyWith(
        id: json.decode(response.body)['name']
      )
    );
    notifyListeners();

  }

  Future<void> loadProducts() async {
    final response = await http.get(
      ///Agora toda requisição ao firebase que fizermos precisamos
      ///do [token] do usuário já que editamos as regras lá no banco e 
      ///colocamos que era necessário o token. Então, para isso basta
      ///após a url passar como query param a chave [auth] com o 
      ///valor do token. O problema é que não temos esse token aqui,
      ///até podíamos criar uma variável e receber via construtor,
      ///porém, o [Products] é instanciado no [main.dart], e nesse
      ///momento não temos o token, temos apenas após ser feito o 
      ///login. Para isso, temos que trocar lá no [main.dart] o 
      ///[ChangeNotifierProvider] pelo [ChangeNotifierProxyProvider].
      '${Application.productsUrl}.json?auth=$_token',
    );

    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();

    if (data != null) {
      data.forEach((productId, productData) {
        _items.add(
          Product.fromJson(
            json.encode(productData)
          ).copyWith(
            id: productId
          ),
        );
      });

      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      await http.patch(
        '${Application.productsUrl}/${product.id}.json',
        body: product.toJson(
          hasId: false,
          hasFavorite: false
        ),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {    
    final index = _items.indexWhere((prod) => prod.id == id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        '${Application.productsUrl}/${product.id}.json'
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto');
      }
    }
  }
}