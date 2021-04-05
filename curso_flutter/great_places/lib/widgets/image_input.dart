import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

typedef UpdateImage = void Function(File);

class ImageInput extends StatefulWidget {
  ImageInput(
    this.onSelectImage
  );

  final UpdateImage onSelectImage;

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

      ///Precisaremos armazenar essa imagem em 
      ///algum lugar persistente dentro da aplicação
      ///antes de chamar o método [onSelectImage].
      ///Para isso precisaremos de + 2 dependências:
      ///[path_provider] e do [path]. Ao importar a
      ///dependência [path] pode ser que dê erro 
      ///dizendo que o [flutter_test] depende de uma
      ///versão mais atualizada desse [path] e nós
      ///estamos usando uma versão mais antiga. Nesse
      ///momento, só funcionou importanto a seguinte
      ///versão do [path]:
      ///path: 1.8.0-nullsafety.1
      ///Essa versão era a pedida na mensagem de erro
      ///do próprio pubspec ao dar um flutter clean
      ///A ideia é salvar essa imagem dentro de um 
      ///diretório da nossa aplicação a partir dessas
      ///2 dependências que instalamos
      
      ///Pegando a pasta que podemos armazenar 
      ///documentos dentro da nossa aplicação:
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      ///Pegando apenas o nome da imagem para colocá-la
      ///dentro do diretório da nossa aplicação
      var fileName = path.basename(_storedImage.path);
      final savedImage = await _storedImage.copy(
        '${appDir.path}/$fileName'
      );
      widget.onSelectImage(savedImage);
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