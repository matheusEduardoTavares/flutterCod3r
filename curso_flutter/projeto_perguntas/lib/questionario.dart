import 'package:flutter/material.dart';
import 'questao.dart';
import 'resposta.dart';

class Questionario extends StatelessWidget {
  final List<Widget> columnContent;
  final MainAxisAlignment mainAxisAlignement;
  final CrossAxisAlignment crossAxisAlignement;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;
  final List<Map<String, Object>> questions;
  final int selectedQuestion;
  final bool hasSelectedQuestion;
  final VoidCallback onPressed;

  Questionario({
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
            (questions[selectedQuestion]['respostas'] as List<String>).map((resposta) => Resposta(
              raisedButtonText: resposta,
              raisedButtonOnPressed: onPressed,
            )
        ) : []),
      ]
    );
  }
}