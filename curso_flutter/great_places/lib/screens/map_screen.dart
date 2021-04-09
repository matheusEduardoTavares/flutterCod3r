import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/mapbox_util.dart';
import 'package:mapbox_gl/mapbox_gl.dart' as mapBox;

class MapScreen extends StatefulWidget {
  const MapScreen({
    this.useGoogleMap = false,
    this.initialLocation,
    this.isReadOnly = false,
  });
  
  final bool useGoogleMap;
  final PlaceLocation initialLocation;

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

    _currentPosition = widget.initialLocation;

    _currentPosition ??= PlaceLocation(
      latitude: MapScreen.googleHeardquartersLatitude,
      longitude: MapScreen.googleHeardquartersLongitude,
    );

    _useGoogleMap = widget.useGoogleMap ?? false;
  }

  void _addSymbol(double latitude, double longitude, {bool clearOtherSymbols = true, double iconSize, String iconImage}) {
    if (clearOtherSymbols ?? false) {
      _mapBoxMapController.clearSymbols();
    }
    _mapBoxMapController.addSymbol(mapBox.SymbolOptions(
      geometry: mapBox.LatLng(
        latitude,
        longitude,
      ),
      iconImage: iconImage ?? 'embassy-11',
      iconSize: iconSize ?? 3.0,
    ));
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
        _addSymbol(
          latitude,
          longitude,
        );
      }
    });
  }

  void _addDefaultSymbol(double latitude, double longitude, {bool clearOtherSymbols = true, double iconSize, String iconImage}) {
    _addSymbol(
      latitude,
      longitude,
      clearOtherSymbols: clearOtherSymbols,
      iconSize: iconSize,
      iconImage: iconImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione...'),
        actions: [
          if (!(widget.isReadOnly ?? false))
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
        onTap: widget.isReadOnly ?? false ? null :
          (latLng) => _selectPosition(
            latLng.latitude,
            latLng.longitude
          ),
        markers: ((_hasMarkerGoogleMap ?? false) && (!widget.isReadOnly ?? false)) 
          ? null : {
            Marker(
              markerId: MarkerId('p1'),
              position: LatLng(
                _pickedPosition.latitude ?? widget.initialLocation.latitude,
                _pickedPosition.longitude ?? widget.initialLocation.longitude,
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
        onStyleLoadedCallback: (!widget.isReadOnly ?? false) ? () {} :
          () => _addDefaultSymbol(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
        onMapCreated: (mapboxMapController) {
          _mapBoxMapController = mapboxMapController;
        },
        onMapClick: widget.isReadOnly ?? false ? null :
          (_, latLng) => _selectPosition(
            latLng.latitude,
            latLng.longitude
          ),
      )
    );
  }
}