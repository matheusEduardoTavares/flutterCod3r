import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items => List<Place>.from(_items);

  int get itemsCount => _items.length;

  Place itemByIndex(int index) => _items[index];

  Place itemById(String id) {
    final filteredItem = _items.singleWhere(
      (place) => place.id == id,
      orElse: () => null
    );

    return filteredItem;
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: null,
    );

    _items.add(newPlace);
    notifyListeners();
  }
}