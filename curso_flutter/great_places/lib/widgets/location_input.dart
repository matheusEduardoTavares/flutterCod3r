import 'package:flutter/material.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
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

  Future<void> _getCurrentUserLocation([bool useGoogleMap]) async {
    final locData = await Location().getLocation();
    
    if (useGoogleMap ?? false) {
      ///Uso com o GoogleMaps.
      final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: locData.latitude,
        longitude: locData.longitude,
      );

      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
    }
    else {
      //TODO! Implementar.
      ///Uso com Mapbox.
      print('Ainda não implementado');
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
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

    if (selectedLocation == null) return;

    // ...
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