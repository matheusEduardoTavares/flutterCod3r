import 'package:campo_minado/components/field_widget.dart';
import 'package:campo_minado/models/trabuleiro.dart';
import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  BoardWidget({ 
    @required this.onChangeMarcation,
    @required this.board,
    @required this.onOpen,
    Key key,
  }) : super(key: key);

  final Tabuleiro board;
  final ChangeMarcationHook onChangeMarcation;
  final OpenHook onOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.colunas,
        children: board.campos.map(
          (field) => FieldWidget(
            field: field, 
            onOpen: onOpen, 
            onChangeMarcation: onChangeMarcation,
          ),
        ).toList(),
      ),
    );
  }
}