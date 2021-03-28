import 'dart:convert';
import 'dart:math';
import './cart.dart';
import 'package:flutter/foundation.dart';
import 'package:shop/application/application.dart';
import 'package:http/http.dart' as http;

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

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      '${Application.ordersUrl}.json',
      body: json.encode({
        'total': cart.totalAmount,
        ///Serve para colocar em um formato padronizado que é
        ///fácil de reverter quando precisar carregar os dados
        ///do firebase
        'date': date.toIso8601String(),
        'products': cart.items.values.map((cartItem) => {
          'id': cartItem.id,
          'productId': cartItem.productId,
          'title': cartItem.title,
          'quantity': cartItem.quantity,
          'price': cartItem.price,
        }).toList(),
      }),
    );

    _items.insert(0, Order(
      id: json.decode(response.body)['name'],
      total: cart.totalAmount,
      date: date,
      products: cart.items.values.toList()
    ));

    notifyListeners();
  }
}