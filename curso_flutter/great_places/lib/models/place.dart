import 'dart:io';
///Além do [meta] que podemos importar, temos o 
///[foundation] para poder usar o annotation do 
///[@required]
import 'package:flutter/foundation.dart';

class PlaceLocation {
  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address
  });

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  const Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });

  final String id;
  final String title;
  final PlaceLocation location;
  final File image;
}