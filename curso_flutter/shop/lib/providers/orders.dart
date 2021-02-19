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
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(List<CartItem> products, double total) {
    // final combine = (total, currentCartItem) => 
    //   total + (currentCartItem.price * currentCartItem.quantity);

    // var total = products.fold(0.0, combine);

    _orders.insert(0, Order(
      id: Random().nextDouble().toString(),
      total: total,
      date: DateTime.now(),
      products: products
    ));

    notifyListeners();
  }
}