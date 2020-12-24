import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pointing;
  final Widget content;
  final String text;
  final double widthFactor;
  final double heightFactor;
  final TextStyle textStyle;
  final int maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final bool softWrap;
  final VoidCallback onPressedRestartApp;

  const Resultado({
    Key key,
    @required this.pointing,
    @required this.onPressedRestartApp,
    this.content,
    this.text,
    this.widthFactor,
    this.heightFactor,
    this.textStyle,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
  }) : super(key: key);

  String get fraseResultado {
    if (pointing < 8) {
      return 'Parabéns!';
    }
    else if (pointing < 12) {
      return 'Você é bom!';
    }
    else if (pointing < 16){
      return 'Impressionante!';
    }
    else {
      return 'Nível Jedi!';
    }
  }

  @override 
  Widget build(BuildContext context){
    return Center(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: content ?? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text ?? fraseResultado,
            style: textStyle ?? TextStyle(fontSize: 28),
            maxLines: maxLines,
            overflow: overflow,
            textAlign: textAlign,
            softWrap: softWrap
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('Reiniciar aplicação'),
            onPressed: onPressedRestartApp,
          )
        ],
      ),
    );
  }
}

/*
Código da aula:

class Resultado extends StatelessWidget {

  final int pontuacao;
  final void Function() quandoReiniciarQuestionario;

  Resultado(this.pontuacao, this.quandoReiniciarQuestionario);

  String get fraseResultado {
    if (pontuacao < 8) {
      return 'Parabéns!';
    }
    else if (pontuacao < 12) {
      return 'Você é bom!';
    }
    else if (pontuacao < 16){
      return 'Impressionante!';
    }
    else {
      return 'Nível Jedi!';
    }
  }

  @override 
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            pontuacao,
            style: TextStyle(fontSize: 28),
          )
        ),
        FlatButton(
          child: Text('Reiniciar?, style: TextStyle(fontSize: 18,)),
          textColor: Colors.blue,
          //Caso de comunicação indireta:
          onPressed: quandoReiniciarQuestionario,
        )
      ]
    );
  }
}

*/