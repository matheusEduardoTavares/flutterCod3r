import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef UpdateImage = Function(File);

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(
    this.onImagePick,
  );

  final UpdateImage onImagePick;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    ///Objetivando diminuir o tamanho da imagem para não salvarmos imagens muito
    ///pesadas, iremos passar um [imageQuality] de 50 e um [maxWidth] de 150,
    ///assim diminuímos a qualidade da imagem padrão, e limitamos a largura da
    ///imagem.
    final pickedImage = await picker
      .getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );

    if (pickedImage != null) {
      setState(() {
        _pickedImageFile = File(pickedImage.path);
      });

      widget.onImagePick(_pickedImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImageFile != null ? FileImage(
            _pickedImageFile,
          ) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Adicionar Imagem'),
        ),
      ],
    );
  }
}