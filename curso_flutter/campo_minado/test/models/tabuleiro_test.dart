import 'package:campo_minado/models/trabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Ganhar Jogo',
    () {

      final tabuleiro = Tabuleiro(
        linhas: 2,
        colunas: 2,
        qtdeBombas: 0,
      );

      tabuleiro.campos[0].minar();
      tabuleiro.campos[3].minar();

      /// Esta é uma das formas que deveríamos ganhar o 
      /// jogo, pois para ganhar tem que marcar os que 
      /// tem bomba com a flag, e abrir os que não tem bomba,
      /// e segundo o que minamos na mão nas linhas 15 e 16,
      /// o jogo feito abaixo deve garantir vencer o game
      tabuleiro.campos[0].alternarMarcacao();
      tabuleiro.campos[1].abrir();
      tabuleiro.campos[2].abrir();
      tabuleiro.campos[3].alternarMarcacao();

      expect(tabuleiro.resolvido, isTrue);
    }
  );
}