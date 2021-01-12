import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    //No caso das tela favorita, diferente das outras
    //3 telas que temos no momento, ela não será 
    //construída usando um Scaffold, pois o componente
    //scaffold estará dentro do componente que criaremos
    //agora. Criaremos um componente que irá mostrar e
    //um componente que irá controlar as abas, a 
    //transição entre um componente e outro.
    return Center(
      child: Text('Minhas Refeições favoritas'),
    );
  }
}