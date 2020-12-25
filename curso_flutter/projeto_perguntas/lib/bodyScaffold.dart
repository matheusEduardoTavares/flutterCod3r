import 'package:flutter/material.dart';
import 'questionario.dart';
import 'resultado.dart';

class _BodyScaffoldState extends State<BodyScaffold> {
  final _perguntas = const [
      {
        'texto': 'Qual é a sua cor favorita?',
        'respostas': [
          {'texto': 'Preto', 'pontuacao': 10 },
          {'texto': 'Vermelho', 'pontuacao': 5 },
          {'texto': 'Verde', 'pontuacao': 3 },
          {'texto': 'Branco', 'pontuacao': 1 }
        ]
      },
      {
        'texto': 'Qual é o seu animal favorito?',
        'respostas': [
          {'texto': 'Coelho', 'pontuacao': 10 },
          {'texto': 'Cobra', 'pontuacao': 5 },
          {'texto': 'Elefante', 'pontuacao': 3 },
          {'texto': 'Leão', 'pontuacao': 1 },
        ]
      },
      {
        'texto': 'Qual é o seu instrutor favorito?',
        'respostas': [
          { 'texto': 'Leo', 'pontuacao': 10 },
          { 'texto': 'Maria', 'pontuacao': 5 },
          { 'texto': 'João', 'pontuacao': 3 },
          { 'texto': 'Pedro', 'pontuacao': 1 },
        ]
      },
    ];

  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada){
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  void _restartApp(BuildContext ctx) async {
    bool choose = await showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Text('Reiniciar questionário'),
        content: Text('Realmente deseja reiniciar o questionário ?'),
        actions: [
          FlatButton(
            child: Text('CANCELAR'),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      )
    );

    if (choose == null || choose == false) return;

    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  @override 
  Widget build(BuildContext context){
    return temPerguntaSelecionada ? Questionario(
      hasSelectedQuestion: temPerguntaSelecionada,
      questions: _perguntas,
      selectedQuestion: _perguntaSelecionada,
      onPressed: _responder,
    ) : Resultado(pointing: _pontuacaoTotal, onPressedRestartApp: () => _restartApp(context),);
  }
}

class BodyScaffold extends StatefulWidget {
  @override 
  _BodyScaffoldState createState() => _BodyScaffoldState();
}