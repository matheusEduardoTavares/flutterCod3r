import 'dart:io';
import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  TextEditingController _titleController;
  File _pickedImage;
  PlaceLocation _pickedPosition;
  FocusNode _titleFocusNode;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(PlaceLocation location) {
    setState(() {
      _pickedPosition = location;
    });
  }

  bool _isValidForm() {
    return _titleController.text.isNotEmpty 
      && _pickedImage != null 
      && _pickedPosition != null;
  }

  @override 
  void initState() {
    super.initState();

    _titleFocusNode = FocusNode();
    _titleController = TextEditingController();
  }

  void _submitForm() {
    if (!_isValidForm()) {
      return;
    }

    Provider.of<GreatPlaces>(
      context,
      listen: false
    ).addPlace(
      _titleController.text,
      _pickedImage,
      _pickedPosition
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                      focusNode: _titleFocusNode,
                    ),
                    const SizedBox(height: 10),
                    ImageInput(
                      this._selectImage,
                      _titleFocusNode,
                    ),
                    const SizedBox(height: 10),
                    LocationInput(
                      _selectPosition,
                      _titleFocusNode,
                    ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Adicionar'),
            color: Theme.of(context).accentColor,
            onPressed: _isValidForm() ? _submitForm : null,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  @override 
  void dispose() {
    _titleController?.dispose();
    _titleFocusNode?.dispose();

    super.dispose();
  }
}