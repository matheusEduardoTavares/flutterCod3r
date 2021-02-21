import 'dart:math';

import 'package:flutter/foundation.dart';

import './cart.dart';

class Order {
  
  const Order({
    this.id,
    this.total,
    this.products,
    this.date
  });

  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  /*
  void addOrder(List<CartItem> products, double total) {
    // final combine = (total, currentCartItem) => 
    //   total + (currentCartItem.price * currentCartItem.quantity);

    // var total = products.fold(0.0, combine);

    _items.insert(0, Order(
      id: Random().nextDouble().toString(),
      total: total,
      date: DateTime.now(),
      products: products
    ));

    notifyListeners();
  }
  */

  ///Outra abordagem para adicionar um novo order:
  void addOrder(Cart cart) {
    _items.insert(0, Order(
      id: Random().nextDouble().toString(),
      total: cart.totalAmount,
      date: DateTime.now(),
      products: cart.items.values.toList()
    ));

    notifyListeners();
  }
}