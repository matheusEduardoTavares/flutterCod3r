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
    this.isReadOnly = false,
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

  ///Define se quer criar um mapa que seja somente de leitura
  final bool isReadOnly;

  static const googleHeardquartersLatitude = 37.422;
  static const googleHeardquartersLongitude = -122.084;
  static const initialZoom = 13.0;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PlaceLocation _pickedPosition;
  PlaceLocation _currentPosition;
  bool _useGoogleMap;
  mapBox.MapboxMapController _mapBoxMapController;
  var _hasMarkerGoogleMap = false;

  @override 
  void initState() {
    super.initState();

    if (widget.useGoogleMap != null && widget.useGoogleMap) {
      _currentPosition = widget.googleMapLocation;
    }
    else {
      _currentPosition = widget.initialLocation == null ||
        widget.initialLocation.latitude == null || 
        widget.initialLocation.longitude == null ? null :
        PlaceLocation(
          latitude: widget.initialLocation.latitude,
          longitude: widget.initialLocation.longitude,
        );
    }

    _currentPosition ??= PlaceLocation(
      latitude: MapScreen.googleHeardquartersLatitude,
      longitude: MapScreen.googleHeardquartersLongitude,
    );

    _useGoogleMap = widget.useGoogleMap ?? false;
  }

  void _selectPosition(double latitude, double longitude) {
    setState(() {
      _pickedPosition = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
      );

      if (_useGoogleMap ?? false) {
        _hasMarkerGoogleMap = true;
      }
      else {
        _mapBoxMapController.clearSymbols();
        _mapBoxMapController.addSymbol(mapBox.SymbolOptions(
          geometry: mapBox.LatLng(
            _pickedPosition.latitude,
            _pickedPosition.longitude,
          ),
          iconImage: 'embassy-11',
          iconSize: 3.0,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione...'),
        actions: [
          if (!(widget.isReadOnly ?? true))
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedPosition != null ? () {
                Navigator.of(context).pop(
                  _pickedPosition
                );
              } : null,
            ),
        ],
      ),
      body: _useGoogleMap ? GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          zoom: MapScreen.initialZoom,
        ),
        onTap: widget.isReadOnly ?? true ? null :
          (latLng) => _selectPosition(
            latLng.latitude,
            latLng.longitude
          ),
        markers: _hasMarkerGoogleMap ?? false ? null : {
          Marker(
            markerId: MarkerId('p1'),
            position: LatLng(
              _pickedPosition.latitude,
              _pickedPosition.longitude,
            ),
          ),
        },
      ) : mapBox.MapboxMap(
        accessToken: MapboxUtil.mapboxApiKey,
        initialCameraPosition: mapBox.CameraPosition(
          target: mapBox.LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          zoom: MapScreen.initialZoom,
        ),
        onStyleLoadedCallback: () {},
        onMapCreated: (mapboxMapController) {
          _mapBoxMapController = mapboxMapController;
        },
        onMapClick: (_, latLng) => _selectPosition(
          latLng.latitude,
          latLng.longitude
        ),
      )
    );
  }
}