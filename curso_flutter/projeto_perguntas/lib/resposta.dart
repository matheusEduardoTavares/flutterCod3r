import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final VoidCallback raisedButtonOnPressed;
  final String raisedButtonText;
  final Widget raisedButtonChild;

  const Resposta({
    @required this.raisedButtonOnPressed,
    this.raisedButtonText,
    this.raisedButtonChild
  }) : assert(
    raisedButtonChild != null || raisedButtonText != null,
    'É necessário passar ou o raisedButtonChild ou o raisedButtonText'
  );

  @override 
  Widget build(BuildContext context){
    return RaisedButton(
      child: raisedButtonChild ?? Text(raisedButtonText),
      onPressed: raisedButtonOnPressed
    );
  }
}