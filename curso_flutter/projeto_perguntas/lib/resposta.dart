import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final VoidCallback raisedButtonOnPressed;
  //final void Function() quandoSelecionado;
  final String raisedButtonText;
  final Widget raisedButtonChild;

  const Resposta({
    @required this.raisedButtonOnPressed,
    // this.quandoSelecionado,
    this.raisedButtonText,
    this.raisedButtonChild
  }) : assert(
    raisedButtonChild != null || raisedButtonText != null,
    'É necessário passar ou o raisedButtonChild ou o raisedButtonText'
  );

  @override 
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: raisedButtonChild ?? Text(raisedButtonText),
        onPressed: raisedButtonOnPressed,
        // onPressed: quandoSelecionado,
        color: Colors.blue,
        textColor: Colors.white
      ),
    );
  }
}

/*
Implementação da aula:

class Resposta extends StatelessWidget {
  final String texto;

  Resposta(this.texto);

  @override 
  Widget build(BuildContext context){
    return RaisedButton(
      child: Text(texto),
      onPressed: null
    );
  }
}
*/