import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/mapbox_util.dart';
import 'package:mapbox_gl/mapbox_gl.dart' as mapBox;

class MapScreen extends StatefulWidget {
  const MapScreen({
    this.useGoogleMap = false,
    this.googleMapLocation,
    this.initialLocation = const mapBox.LatLng(
      googleHeardquartersLatitude, 
      googleHeardquartersLongitude
    ),
  }) : assert(
    !(!useGoogleMap && initialLocation == null),
    'Se não for usado o mapa do google, então o '
    'initialLocation deve ser passado para ser usado '
    'no mapbox'
  );
  // , assert(
  //   useGoogleMap == null || !useGoogleMap ||
  //   (useGoogleMap && googleMapLocation != null),
  //   'Se o useGoogleMap for true, o googleMapLocation'
  //   ' não pode ser nulo'
  // );
  

  ///Define for [true], será utilizado como mapa o
  ///[GoogleMap], se não, será utilizado o 
  ///[MapboxMapGl]
  final bool useGoogleMap;
  final PlaceLocation googleMapLocation;
  final mapBox.LatLng initialLocation;

  static const googleHeardquartersLatitude = 37.422;
  static const googleHeardquartersLongitude = -122.084;
  static const initialZoom = 13.0;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PlaceLocation _placeLocation;
  bool _useGoogleMap;

  @override 
  void initState() {
    super.initState();

    if (widget.useGoogleMap != null && widget.useGoogleMap) {
      _placeLocation = widget.googleMapLocation ?? PlaceLocation(
        latitude: MapScreen.googleHeardquartersLatitude,
        longitude: MapScreen.googleHeardquartersLongitude,
      );
    }

    _useGoogleMap = widget.useGoogleMap ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione...')
      ),
      body: _useGoogleMap ? GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            _placeLocation.latitude,
            _placeLocation.longitude,
          ),
          zoom: MapScreen.initialZoom,
        ),
      ) : mapBox.MapboxMap(
        accessToken: MapboxUtil.mapboxApiKey,
        initialCameraPosition: mapBox.CameraPosition(
          target: widget.initialLocation,
          zoom: MapScreen.initialZoom,
        ),
        onStyleLoadedCallback: () {},
        onMapCreated: (mapboxMapController) {},
      )
    );
  }
}