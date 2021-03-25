import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop/utils/url_firebase.dart';
import 'product.dart';
import '../data/dummy_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {

  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => List.from(_items);

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> addProduct(Product newProduct) {
    ///Esse é um bom local para colocarmos as chamadas 
    ///HTTP, pois é o provider do produto, toda lógica 
    ///relacionada a produtos está aqui. Até poderíamos
    ///criar uma outra classe e encapsular todas as chamadas
    ///HTTP em um único local, mas por enquanto iremos 
    ///colocar aqui.
    
    ///Caso usemos um backend próprio a regra aqui muda, mas
    ///basicamente como queremos criar uma coleção chamada de 
    ///produtos e dentro conter todos os produtos lá no 
    ///realtime database do firebase, então precisamos usar
    ///a URL do banco e colocar no fim /[nome da entidade].json,
    ///o que não é padrão nas rotas de backends próprios, não 
    ///temos rotas com .json no fim, mas no caso do firebase
    ///essa é a regra. Assim o que passarmos no body da requisição
    ///de post será criado como itens de um atributo pai que 
    ///será esse [nome da entidade], que no nosso caso será
    ///products
    final url = '${UrlFirebase.urlFirebase}/products.json';
    
    ///Recebemos aqui a URL
    return http.post(
      url,
      ///Precisamos do formato JSON no conteúdo que 
      ///passamos para a requisição
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'isFavorite': newProduct.isFavorite,
      }),
    ).then((response) {
      _items.add(Product(
        id: json.decode(response.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl,
      ));
      notifyListeners();

      ///Assim podemos retornar um Future vazio:
      // return Future.value();
      ///Mas não é isso que queremos pois esse return
      ///só será chamado depois de chegar a resposta do
      ///servidor, fazendo com que todo o método já 
      ///tivesse sido executado e assim o [Future] na
      ///função não faria sentido.
    });

    // return Future.value();
    ///Não funciona colocar aqui também porquê esse
    ///código será executado por completo e iremos 
    ///retornar algo antes do [response] ter chegado.
    ///O ideal nesse caso é por um return antes do
    ///[http.post] pois será associado a todo o bloco, 
    ///de forma que um [Future] será retornado.
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);

    if (index >= 0) {
      _items.removeWhere((product) => product.id == id);

      notifyListeners();
    }
  }
}