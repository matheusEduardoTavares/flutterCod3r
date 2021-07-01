import 'package:campo_minado/models/campo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Campo', () {
      test('Abrir Campo COM Explosão', () {
        final c1 = Campo(
          linha: 0,
          coluna: 0,
        );

        c1.minar();
        expect(c1.abrir, throwsException);
      });

      test('Abrir campo SEM explosão', () {
        final c1 = Campo(
          linha: 0,
          coluna: 0,
        );

        c1.abrir();
        expect(c1.aberto, isTrue);
      });

      test('Adicionar NÃO Vizinho', () {
        final c1 = Campo(
          linha: 0,
          coluna: 0,
        );

        final c2 = Campo(
          linha: 1,
          coluna: 3,
        );

        c1.adicionarVizinho(
          c2,
        );

        expect(c1.vizinhos.isEmpty, true);
      });

      test('Adicionar Vizinho', () {
        final c1 = Campo(
          linha: 3,
          coluna: 3,
        );

        final c2 = Campo(
          linha: 3,
          coluna: 4,
        );

        final c3 = Campo(
          linha: 2,
          coluna: 2,
        );

        final c4 = Campo(
          linha: 4,
          coluna: 4,
        );

        c1.adicionarVizinho(c2);
        c1.adicionarVizinho(c3);
        c1.adicionarVizinho(c4);

        expect(c1.vizinhos.length, 3);
      });

      test('Minas na Vizinhança ', () {
        final c1 = Campo(
          linha: 3,
          coluna: 3,
        );

        final c2 = Campo(
          linha: 3,
          coluna: 4,
        );
        c2.minar();

        final c3 = Campo(
          linha: 2,
          coluna: 2,
        );

        final c4 = Campo(
          linha: 4,
          coluna: 4,
        );
        c4.minar();

        c1.adicionarVizinho(c2);
        c1.adicionarVizinho(c3);
        c1.adicionarVizinho(c4);

        expect(c1.qtdeMinasNaVizinhanca, 2);
      });
    }
  );
}