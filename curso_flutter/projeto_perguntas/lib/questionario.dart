import 'package:flutter/material.dart';
import 'questao.dart';
import 'resposta.dart';

typedef Pointing = void Function(int);

class Questionario extends StatelessWidget {
  final List<Widget> columnContent;
  final MainAxisAlignment mainAxisAlignement;
  final CrossAxisAlignment crossAxisAlignement;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;
  final List<Map<String, Object>> questions;
  final int selectedQuestion;
  final bool hasSelectedQuestion;
  final Pointing onPressed;

  const Questionario({
    this.columnContent,
    this.mainAxisAlignement,
    this.crossAxisAlignement,
    this.mainAxisSize,
    this.verticalDirection,
    this.questions,
    this.selectedQuestion,
    this.hasSelectedQuestion = false,
    this.onPressed
  });

  @override 
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: mainAxisAlignement ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignement ?? CrossAxisAlignment.start,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      verticalDirection: verticalDirection ?? VerticalDirection.down,
      children: columnContent ?? [
        Questao(texto: questions[selectedQuestion]['texto']),
        ...((hasSelectedQuestion ?? false) && questions != null && 
          (selectedQuestion < questions.length && selectedQuestion >= 0) && 
          (questions[selectedQuestion]).containsKey('respostas') && questions[selectedQuestion]['respostas'] != null ? 
            (questions[selectedQuestion]['respostas'] as List<Map<String, Object>>).map((resposta) => Resposta(
              raisedButtonText: resposta['texto'],
              raisedButtonOnPressed: () => onPressed(resposta['pontuacao']),
            )
        ) : []),
      ]
    );
  }
}

/*
Código da aula:

class Questionario extends StatelessWidget {
  //No caso como a classe é stateless e todos os atributos
  //são final, ou seja, constantes, não precisamos 
  //deixá-los privados.

  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) quandoResponder;

  Questionario({
    @required this.perguntas,
    @required this.perguntaSelecionada,
    @required this.quandoResponder,
  });

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override 
  Widget build(BuildContext context){
    List<Map<String, Object>> respostas = temPerguntaSelecionada
      ? perguntas[perguntaSelecionada]['respostas']
      : null;

    return Column(
      children: <Widget> [
        Questao(perguntas[perguntaSelecionada]['texto']),
        ...respostas.map((resp) => Resposta(resp['texto'], () => quandoResponder(resp['pontuacao']))).toList()
      ]
    );
  }
}
*/