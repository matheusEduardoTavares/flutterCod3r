import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData();
    _items.clear();
    _items.addAll(
      dataList.map((item) => Place(
        id: item['id'],
        title: item['title'],
        image: File(item['image']),
        location: null,
      )).toList()
    );

    notifyListeners();
  }

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

  Future<void> addPlace(String title, File image) async {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: null,
    );

    _items.add(newPlace);

    await DbUtil.insert(
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );

    notifyListeners();
  }
}