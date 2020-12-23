import 'package:flutter/material.dart';

class Questao extends StatelessWidget {
  final String texto;

  Questao({ @required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        texto,
        style: TextStyle(fontSize: 28),
        //Só colocar isso não muda nada pois o Text terá
        //exatamente o mesmo tamanho daquilo que é 
        //visível na tela, ou seja, o tamanho do texto
        //aumenta de acordo com seu conteúdo, e quando
        //pedimos para centralizar algo dentro de algo
        //que já está sendo ocupado 100%, por isso não
        //centraliza na tela. Para poder centralizar 
        //então, faremos um wrap no Text com um 
        //container, mas o resultado será o mesmo pois
        //o container tem o mesmo tamanho do seu
        //conteúdo caso não seja passado um width ou
        //um height. Para fazer pegar a largura inteira
        //da tela, basta usarmos para o width o valor
        //double.infinity, estando com esse width definido
        //sem o TextAlign o texto volta para o começo e não
        //para o centro da tela.
        textAlign: TextAlign.center,
      ),
    );
  }
}