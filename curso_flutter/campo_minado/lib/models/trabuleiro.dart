import 'dart:math';

import 'package:flutter/foundation.dart';
import 'campo.dart';

class Tabuleiro {
  Tabuleiro({
    @required this.linhas,
    @required this.colunas,
    @required this.qtdeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  final int linhas;
  final int colunas;
  final int qtdeBombas;

  final List<Campo> _campos = [];

  void reiniciar() {
    _campos.forEach((c) => c.reiniciar());
    _sortearMinas();
  }

  void revelarBombas() {
    _campos.forEach((c) => c.revelarBomba());
  }

  void _criarCampos() {
    for (var l = 0; l < linhas; l++) {
      for (var c = 0; c < colunas; c++) {
        _campos.add(
          Campo(linha: l, coluna: c),
        );
      }
    }
  }

  void _relacionarVizinhos() {
    for(var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(
          vizinho
        );
      }
    }
  }

  void _sortearMinas() {
    var sorteadas = 0;

    if (qtdeBombas > linhas * colunas) {
      return;
    }

    while(sorteadas < qtdeBombas) {
      final i = Random().nextInt(_campos.length);

      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  List<Campo> get campos { 
    return _campos;
  }

  bool get resolvido {
    return _campos.every(
      (c) => c.resolvido,
    );
  }
}