import 'package:campo_minado/models/campo.dart';
import 'package:flutter/material.dart';

typedef OpenHook = void Function(Campo);
typedef ChangeMarcationHook = void Function(Campo);

class FieldWidget extends StatelessWidget {
  const FieldWidget({ 
    @required this.field,
    @required this.onOpen,
    @required this.onChangeMarcation,
    Key key,
  }) : super(key: key);

  final Campo field;
  final OpenHook onOpen;
  final ChangeMarcationHook onChangeMarcation;

  Widget _getImage() {
    String imageToRender;
    int qtyBombs = field.qtdeMinasNaVizinhanca;
    if (field.aberto && field.minado && field.explodido) {
      imageToRender = 'assets/images/bomba_0.jpeg';
    }
    else if (field.aberto && field.minado) {
      imageToRender = 'assets/images/bomba_1.jpeg';
    }
    else if (field.aberto) {
      imageToRender = 'assets/images/aberto_$qtyBombs.jpeg';
    }
    else if (field.marcado) {
      imageToRender = 'assets/images/bandeira.jpeg';
    }
    else {
      imageToRender = 'assets/images/fechado.jpeg';
    }

    return Image.asset(
      imageToRender,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onChangeMarcation(field),
      child: _getImage(),
    );
  }
}