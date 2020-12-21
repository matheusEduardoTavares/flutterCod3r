import 'package:flutter/material.dart';

//Esse primeiro componente que passamos para o runApp
//é o nó raíz da árvore de componentes da aplicação,
//todo resto estará embaixo desse componente raíz, 
//e o componente tem esse método build que recebe
//por parâmetro o BuildContext, e quem passa esse 
//parâmetro é o próprio flutter. Cada componente 
//tem seu próprio contexto, e o componente filho 
//tem como a partir do contexto, o contexto tem a 
//referência para o contexto do pai, e dessa forma
//é possível que um componente pai se comunique com
//um componente filho a partir deste contexto. Mas
//cada componente tem seu próprio contexto.
main() => runApp(PerguntaApp());

//O componente raíz dessa aplicação, portanto, é o 
//PerguntaApp, e ele tem como filho o MaterialApp.

class PerguntaApp extends StatelessWidget{
  //O @override é um decorator para sobrescrever
  //um método que obrigatoriamente o componente
  //stateless precisa implementar, que é o 
  //método build. É o flutter quem chama esse 
  //método.

  void responder() {
    print('Pergunta respondida');
  }

  @override 
  Widget build(BuildContext context){
    // final List<String> perguntas = [
    final perguntas = [
      'Qual é a sua cor favorita?',
      'Qual é o seu animal favorito?',
    ];

    //A criação do nosso widget é o MaterialApp
    return MaterialApp(
      title: 'PerguntaApp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas')
        ),
        body: Column(
          //Não precisa pow <Widget> (generics) para
          //explicitar o tipo da lista.
          children: [
            Text(perguntas[0]),
            RaisedButton(
              child: Text('Resposta 1'),
              //Se deixássemos assim:
              // onPressed: responder , nesse caso não
              //estamos passando o método responder 
              //como parâmetro, e sim passando o retorno
              //deste método, já que o estamos executando
              //devido ao ();
              onPressed: responder
            ),
            RaisedButton(
              child: Text('Resposta 2'),
              //Caso criássemos a seguinte função:
              // void Function() funcaoQueRetornaUmaOutraFuncao(){
              //   return () {
              //     print('Pergunta respondida #02!');
              //   };
              // }
              //Agora nesse caso que criamos uma função
              //que retorna outra função, aí sim podemos
              //já chamar essa função executando-a, pois
              //seu retorno será uma função que não 
              //retorna nada (void) e não recebe
              //parâmetros, justamente o que precisamos
              //passar para o onPressed
              // onPressed: funcaoQueRetornaUmaOutraFuncao()
              onPressed: () {
                print('Resposta 2 foi selecionada!');
              }
              //O botão só fica habilitado para clique
              //caso seu onPressed seja != null
            ),
            RaisedButton(
              child: Text('Resposta 3'),
              onPressed: () => print('Resposta 3 foi selecionada!')
            ),
            //Portanto ou passamos como referência uma
            //função que criamos ou passamos a função
            //de forma literal.
          ]
        ),
      )
    );
  }
}