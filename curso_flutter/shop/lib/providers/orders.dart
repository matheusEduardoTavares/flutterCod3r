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

  Future<void> loadOrders() async {
    List<Order> loadedItems = [];

    final response = await http.get(
      '${Application.ordersUrl}.json',
    );

    Map<String, dynamic> data = json.decode(response.body);

    if (data != null) {
      data.forEach((orderId, orderData) {
        loadedItems.add(
          Order(
            id: orderId,
            total: orderData['total'],
            date: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                id: item['id'],
                price: item['price'],
                productId: item['productId'],
                quantity: item['quantity'],
                title: item['title'],
              )).toList()
          ),
        );
      });

      ///Fazemos isso para que os pedidos mais novos fiquem 
      ///em cima e os mais antigos em baixo
      _items = loadedItems.reversed.toList();

      notifyListeners();
    }
  }
}