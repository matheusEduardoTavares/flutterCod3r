import 'dart:math';
import 'package:flutter/foundation.dart';
import './product.dart';

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
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items}; 

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    var total = _items.values.fold(0.0, (accumulator, currentItem) => (currentItem.price * currentItem.quantity) + accumulator);
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) => CartItem(
        id: existingItem.id,
        productId: product.id,
        price: existingItem.price,
        quantity: existingItem.quantity + 1,
        title: existingItem.title,
      ));
    }
    else {
      _items.putIfAbsent(product.id, () => CartItem(
        id: Random().nextDouble().toString(),
        productId: product.id,
        price: product.price,
        quantity: 1,
        title: product.title
      ));
    }

    notifyListeners();
  }

  void removeSingleItem(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId].quantity == 1) {
      _items.remove(productId);
    }
    else {
      _items.update(productId, (existingItem) {
        return CartItem(
          id: existingItem.id,
          // productId: existingItem.productId,
          //Ou (tanto faz):
          productId: productId,
          title: existingItem.title,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        );
      });
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}