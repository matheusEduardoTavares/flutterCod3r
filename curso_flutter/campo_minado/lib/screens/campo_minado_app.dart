import 'package:campo_minado/components/board_widget.dart';
import 'package:campo_minado/models/trabuleiro.dart';
import 'package:flutter/material.dart';
import '../components/resultado_widget.dart';
import '../models/campo.dart';

class CampoMinadoApp extends StatelessWidget {
  const CampoMinadoApp({ Key key }) : super(key: key);

  void _reiniciar() {
    print('reiniciar');
  }

  void _open(Campo field) {
    print('open...');
  }

  void _changeMarcation(Campo field) {
    print('changeMarcation...');
  }

  @override
  Widget build(BuildContext context) {
    // final field = Campo(
    //   linha: 0,
    //   coluna: 0,
    // );

    // final otherField1 = Campo(
    //   linha: 1,
    //   coluna: 0,
    // );
    // final otherField2 = Campo(
    //   linha: 1,
    //   coluna: 1,
    // );
    // otherField1.minar();
    // otherField2.minar();
    // field.adicionarVizinho(otherField1);
    // field.adicionarVizinho(otherField2);

    // try {
    //   // field.minar();
    //   // field.abrir();
    //   field.alternarMarcacao();
    // } on ExplosaoException {}

    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: null,
          onReiniciar: _reiniciar,
        ),
        body: Container(
          child: BoardWidget(
            board: Tabuleiro(
              linhas: 15,
              colunas: 15,
              qtdeBombas: 10,
            ),
            onOpen: _open,
            onChangeMarcation: _changeMarcation,
          ),
        ),
      ),
    );
  }
}