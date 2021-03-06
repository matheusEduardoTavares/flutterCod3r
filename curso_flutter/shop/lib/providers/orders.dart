import 'dart:convert';
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

  String _token;
  String _userId;

  Orders([
    this._token,
    this._userId,
    this._items = const []
  ]);

  String _getUrlWithToken(String url) {
    return '$url?auth=$_token';
  }

  int get itemsCount => _items.length;

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      _getUrlWithToken('${Application.ordersUrl}/$_userId.json'),
      body: json.encode({
        'total': cart.totalAmount,
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
      _getUrlWithToken('${Application.ordersUrl}/$_userId.json'),
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

      _items = loadedItems.reversed.toList();

      notifyListeners();
    }
  }
}