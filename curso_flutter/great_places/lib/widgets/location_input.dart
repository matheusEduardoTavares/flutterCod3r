import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

typedef UpdatePosition = void Function(PlaceLocation);

class LocationInput extends StatefulWidget {
  const LocationInput(
    this.onSelectPosition,
    this.titleFocusNode,
  );

  final UpdatePosition onSelectPosition;
  final FocusNode titleFocusNode;

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  ///Será gerado uma imagem de preview de acordo com a 
  ///localização setada. Quem irá fornecer isso para nós
  ///será a pŕopria API do maps do google. Na verdade
  ///nessa variável ficará a URL da imagem pois 
  ///ela estará na rede.
  String _previewImageUrl;

  void _showPreview(double latitude, double longitude, {bool useGoogleMap = false}) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
      useGoogleMap: useGoogleMap ?? false,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation([bool useGoogleMap = false]) async {
    try {
      widget.titleFocusNode?.unfocus();
      final locData = await Location().getLocation();

      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPosition(PlaceLocation(
        latitude: locData.latitude,
        longitude: locData.longitude,
      ));
    }
    catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap({bool useGoogleMap = false}) async {
    widget.titleFocusNode?.unfocus();
    final selectedPosition = await Navigator.of(context).push<PlaceLocation>(
      MaterialPageRoute(
        ///Se passarmos o [fullscreenDialog] como true,
        ///continuará exibindo com a tela inteira pois
        ///é o que já fazemos, porém muda um pouco pois
        ///o ícone da [AppBar] será um X ao invés de 
        ///uma seta para voltar
        fullscreenDialog: true,
        builder: (ctx) => MapScreen()
      ),
    );

    if (selectedPosition == null) return;

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);
    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
          child: _previewImageUrl == null ? Text('Localização não informada') : 
            Image.network(
              _previewImageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Localização Atual'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Selecione no Mapa'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}