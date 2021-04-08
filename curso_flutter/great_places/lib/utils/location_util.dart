import 'package:great_places/utils/mapbox_util.dart';

///Como não estou usando a API KEY do google, 
///deixarei aqui uma String vazia
const GOOGLE_API_KEY = '';

class LocationUtil {
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

    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$longitude,$latitude,13.0,0,60/600x600?'
      'access_token=${MapboxUtil.mapboxApiKey}';
  }
}