import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/mapbox_util.dart';
import 'package:http/http.dart' as http;

///Como não estou usando a API KEY do google, 
///deixarei aqui uma String vazia
const GOOGLE_API_KEY = '';

abstract class LocationUtil {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
    bool useGoogleMap = false,
  }) {
    if (useGoogleMap ?? false) {
      return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap'
        '&markers=color:red%7Clabel:A%7C$latitude,$longitude'
        '&key=$GOOGLE_API_KEY';
    }

    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l-embassy+f74e4e'
      '($longitude,$latitude)/$longitude,$latitude,13.0,0,60/600x600?'
      'access_token=${MapboxUtil.mapboxApiKey}';
  }

  static Future<String> getAddressFrom(PlaceLocation position, {bool useGoogleMap = false}) async {
    if (useGoogleMap ?? false) {
      final googlePosition = LatLng(
        position.latitude,
        position.longitude,
      );
      final url = 'https://maps.googleapis.com/maps/api/'
        'geocode/json?latlng=${googlePosition.latitude},'
        '${googlePosition.longitude}&key=$GOOGLE_API_KEY';
      final response = await http.get(url);
      return json.decode(response.body)['results'][0]['formatted_address'];
    }
    else {
      await Future.delayed(const Duration(seconds: 2));
      return 'Local-${DateTime.now()}';
    }
  }
}