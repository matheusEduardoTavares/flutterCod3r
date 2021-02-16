//Além de usar o import do material, podemos usar o 
//foundation.dart para ter acesso ao mixin ChangeNotifier
import 'dart:math';
import 'package:flutter/foundation.dart';
import './product.dart';

//Aqui teremos 2 classes pois são 2 classes que são
//muito ligadas: o carrinho e o item do carrinho.

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  
  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  //chave = id do produto, valor = item do carrinho
  //A partir do momento que colocamos um MultiProvider
  //passamos a fazer o items receber um Map vazio para
  //inicializá-lo, para garnatir que a variável
  //_items não fique nulo, pois se tentarmos 
  //adicionar um produto e o map não tiver sido
  //inicializado, irá dar erro, então temos que 
  //inicializar o map.
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items}; 

  //Getter que retorna a quantidade de elementos
  //dentro do carrinho.
  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    // double total = 0.0;
    // _items.forEach((key, cartItem) { 
    //   total += cartItem.price * cartItem.quantity;
    // });

    var total = _items.values.fold(0.0, (accumulator, currentItem) => (currentItem.price * currentItem.quantity) + accumulator);
    return total;
  }

  //Se o item não estiver no carrinho o adicionamos, mas
  //se o item já estiver no carrinho devemos aumentar a
  //quantidade.
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      // Para atualizar um map podemos usar o método update,
      // em que passamos a chave como primeiro parâmetro, e
      // o segundo parâmetro é uma função que tem como 
      // parâmetro o valor daquela chave existente dentro do
      // map
      _items.update(product.id, (existingItem) => CartItem(
        id: existingItem.id,
        productId: product.id,
        price: existingItem.price,
        quantity: existingItem.quantity + 1,
        title: existingItem.title,
      ));
    }
    else {
      //Já o método putIfAbsent serve para incluir
      _items.putIfAbsent(product.id, () => CartItem(
        //O id é o ID do item do carrinho, não é o ID do
        //produto, pois ele é a chave do map _items.
        id: Random().nextDouble().toString(),
        productId: product.id,
        price: product.price,
        quantity: 1,
        title: product.title
      ));
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}