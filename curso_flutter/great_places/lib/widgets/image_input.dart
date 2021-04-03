import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    ///Primeiro importamos a lib [image_picker], aí
    ///aqui para tirar uma foto instanciamos o 
    ///[ImagePicker] e usamos o método [getImage] 
    ///dele. Conseguimos definir para ele buscar 
    ///uma foto da galeria ou tirar uma foto a partir
    ///do atributo [source] que passamos para esse 
    ///método [getImage], em que o [ImageSource.camera]
    ///é para tirar foto, e o [ImageSource.gallery] é
    ///para buscar uma imagem da galeria
    final _picker = ImagePicker();
    final _imageFile = await _picker.getImage(
      source: ImageSource.camera,
      ///Como hoje em dia temos câmeras com 108 megaPixels
      ///que é uma imagem gigantesca, podemos restringir isso
      ///para a necessidade da aplicação, definindo uma 
      ///largura máxima da imagem
      maxWidth: 600,
    );

    ///Caso o usuário feche a tela de captura de 
    ///imagem sem tirar uma foto, o [_imageFile] 
    ///ficará null
    if (_imageFile != null) {
      setState(() {
        _storedImage = File(_imageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
          ///Centralizando o conteúdo dentro do 
          ///[Container]
          alignment: Alignment.center,
          child: _storedImage != null ? 
            Image.file(
              _storedImage,
              ///Cobre apenas a área disponível:
              fit: BoxFit.cover,
              ///Devido ao [BoxFit.cover] não tem 
              ///problema colocar para o [width] ser
              ///o [double.infinity]
              width: double.infinity,
            ) : Text('Nenhuma imagem!'),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Tirar Foto'),
            textColor: Theme.of(context)
              .primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}