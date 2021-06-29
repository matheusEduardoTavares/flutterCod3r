import 'package:flutter/foundation.dart';
import 'explosao_exception.dart';

class Campo {
  Campo({
    @required this.linha,
    @required this.coluna,
  });

  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

  ///Se o campo já foi aberto, ou seja, clicado
  var _aberto = false;

  ///Se o campo está fechado
  var _marcado = false;

  ///Se o campo é uma mina
  var _minado = false;
  ///Qual é o campo responsável pelo usuário perder o jogo,
  ///apenas um campo explode e ele fica vermelho, e o campo
  ///que explodirá será o que tem este atributo como true.
  var _explodido = false;

  void adicionarVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    ///Esse caso significa que o [vizinho] é o próprio
    ///campo
    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }
    ///Se a diferença entre a linha e a coluna for 
    ///menor ou igual a um, significa que de fato é um 
    ///vizinho, pois considerando um caso de tabuleiro
    ///3 X 3 , bem no centro (2x2), todos os demais componentes
    ///serão seus vizinhos, pois a diferença entre a linha e a 
    ///coluna deles é 1 ou 0
    else if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abrir() {
    ///Se o campo já foi aberto não precisa fazer nada
    if (_aberto) {
      return;
    }

    _aberto = true;

    ///Se o campo já for minado significa que o usuário 
    ///clicou em um campo minado e portanto  o jogo acabou
    if(_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    ///Agora aqui usaremos recursividade pois devemos ir 
    ///abrindo os campos vizinhos se eles não forem 
    ///minados
    if (vizinhancaSegura) {
      vizinhos.forEach((v) => v.abrir());
    }
  }

  void revelarBomba() {
    if (_minado) {
      _aberto = true;
    }
  }

  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  void minar() {
    _minado = true;
  }

  bool get minado {
    return _minado;
  }

  bool get explodido {
    return _explodido;
  }

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  ///Um campo resolvido é o que o usuário descobriu o que
  ///precisa ser feito, ou seja, se está com bomba tem que
  ///ser marcado, e se está seguro, sem bomba, ele precisa
  ///ser aberto. Esse getter define se o campo já foi 
  ///solucionado
  bool get resolvido {
    var minadoEMarcado = minado && marcado;
    var seguroEAberto = !minado && aberto;
    return minadoEMarcado || seguroEAberto;
  }

  ///Define se pode abrir os campos de forma recursiva
  bool get vizinhancaSegura {
    return vizinhos.every(
      (v) => !v.minado
    );
  }

  ///Quantidade de minas ao redor do campo
  int get qtdeMinasNaVizinhanca {
    return vizinhos.where((v) => v.minado).length;
  }
}