import 'package:campo_minado/components/board_widget.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/trabuleiro.dart';
import 'package:flutter/material.dart';
import '../components/resultado_widget.dart';
import '../models/campo.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({ Key key }) : super(key: key);

  @override
  _CampoMinadoAppState createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool _venceu;
  final _tabuleiro = Tabuleiro(
    linhas: 12, 
    colunas: 12, 
    qtdeBombas: 3,
  );

  void _reiniciar() {
    setState(() {
      _venceu = null;
      _tabuleiro.reiniciar();
    });
  }

  void _open(Campo field) {
    if (_venceu != null) {
      return;
    }

    setState(() {
      try {
        field.abrir();
        if (_tabuleiro.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro.revelarBombas();
      }
    });
  }

  void _changeMarcation(Campo field) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      field.alternarMarcacao();
      if (_tabuleiro.resolvido) {
        _venceu = true;
      }
    });
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
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: Container(
          child: BoardWidget(
            board: _tabuleiro,
            onOpen: _open,
            onChangeMarcation: _changeMarcation,
          ),
        ),
      ),
    );
  }
}