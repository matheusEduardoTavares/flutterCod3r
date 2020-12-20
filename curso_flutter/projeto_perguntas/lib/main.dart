import 'package:flutter/material.dart';

main(){
  runApp(PerguntaApp());
}

class PerguntaApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'PerguntaApp',
      home: Text('Olá Flutter!!!')
    );
  }
}