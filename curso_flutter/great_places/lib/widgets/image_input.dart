import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

typedef UpdateImage = void Function(File);

class ImageInput extends StatefulWidget {
  ImageInput(
    this.onSelectImage,
    this.titleFocusNode,
  );

  final UpdateImage onSelectImage;
  final FocusNode titleFocusNode;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    widget.titleFocusNode?.unfocus();
    final _picker = ImagePicker();
    final _imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (_imageFile != null) {
      setState(() {
        _storedImage = File(_imageFile.path);
      });

      final appDir = await syspaths.getApplicationDocumentsDirectory();
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
          alignment: Alignment.center,
          child: _storedImage != null ? 
            Image.file(
              _storedImage,
              fit: BoxFit.cover,
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