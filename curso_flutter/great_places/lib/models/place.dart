import 'dart:io';
///Além do [meta] que podemos importar, temos o 
///[foundation] para poder usar o annotation do 
///[@required]
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_gl/mapbox_gl.dart' as mapBox;

class PlaceLocation {
  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
    this.useGoogleMap = false,
  });

  final double latitude;
  final double longitude;
  final String address;
  final bool useGoogleMap;

  dynamic toLatLng() {
    if (useGoogleMap ?? false) {
      return LatLng(this.latitude, this.longitude);
    }
    else {
      return mapBox.LatLng(
        this.latitude,
        this.longitude
      );
    }
  }
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