import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

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

/*
O Recomendável é sempre usarmos componentes sem estado,
quantos mais componentes sem estado tivermos, mais fácil
será para gerenciar nossa aplicação. Passamos via 
construtor os parâmetros que precisam ser alterados. O
Stateless não tem estado interno.
*/

//Para trocar de stateless para stateful, criamos 
//outr classe que extende o State da classe stateful,
//e ela terá todas as variáveis cujo valor pode mudar
//, os métodos que mudam esse valor, e também o método
//build. O método build depende do estado da aplicação
//para ser renderizado, por isso ele não fica direto
//dentro da classe stateful, e sim da classe state
//cujo generics denota a classe stateful.
//A classe que representa o estado deixamos privada
//e colocamo um State no fim, por convenção
class _PerguntaAppState extends State<PerguntaApp> {
  //Classes que extendem o StatelessWidget devem
  //ser imutáveis, ou seja, ter atributos apenas final,
  //isso já gera um warning, pois se é preciso haver uma
  //variável cujo valor será alterado, é preciso ter 
  //um estado para alterá-la, então a classe deve 
  //extender o StatefulWidget.
  var _perguntaSelecionada = 0;

  void _responder() {
    /*
      No flutter temos uma ideia de interface reativa,
      no momento que alteramos o valor de uma variável
      de forma reativa será gerado uma atualização na UI
      de forma que conseguimos ver o último estado sendo
      renderizado na tela. Não está acontecendo nada pois
      estamos dentro de um componente stateless, dito
      sem estado. O fato de termos uma variável sendo 
      alterada dentro de um componente stateless é errado
      , violamos essa ideia desse componente.
    */

    //Para UI ser notificada quando houver uma mudança
    //precisamos usar um setState(() {}); , e passamos
    //dentro do corpo desse setState para dentro dele
    //passarmos aquilo que está sendo modificado.
    setState(() {
      _perguntaSelecionada++;
    });

    //O Flutter possui mecanismos de otimização, para
    //mexer exatamente no ponto que precisa ser mexido
    //e a interface gráfica ser renderizada novamente.
    //No momento, o único componente que é renderizado
    //novamente é o Text pois ele é o único que muda 
    //de fato quanto o _perguntaSelecionada é incrementado.
    //Parece ser ineficiente o flutter renderizar toda 
    //árvore de widgets novamente, mas esses mecanismos
    //servem justamente para a questão de performance.
    //Veremos mais a frente, mas o flutter tem a árvore
    //de widgets e a árvore de elementos. A árvore de 
    //widgets permanece lá e a de elementos é renderizada
    //novamente.
  }

  //O @override é um decorator para sobrescrever
  //um método que obrigatoriamente o componente
  //stateless precisa implementar, que é o 
  //método build. É o flutter quem chama esse 
  //método.
  @override 
  Widget build(BuildContext context){
    // final List<String> perguntas = [
    // final List<Map<String, Object>> perguntas = [
    final perguntas = [
      {
        'texto': 'Qual é a sua cor favorita?',
        'respostas': [
          'Preto',
          'Vermelho',
          'Verde',
          'Branco'
        ]
      },
      {
        'texto': 'Qual é o seu animal favorito?',
        'respostas': [
          'Coelho',
          'Cobra',
          'Elefante',
          'Leão',
        ]
      },
      {
        'texto': 'Qual é o seu instrutor favorito?',
        'respostas': [
          'Maria',
          'João',
          'Leo',
          'Pedro',
        ]
      },
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
            Questao(texto: perguntas[_perguntaSelecionada]['texto']),
            ...(perguntas[_perguntaSelecionada]['respostas'] as List<String>).map((resposta) => Resposta(
              raisedButtonText: resposta,
              raisedButtonOnPressed: _responder,
            ))
            /*
              Resposta(
                raisedButtonText: 'Resposta 1',
                //Se deixássemos assim:
                // onPressed: _responder , nesse caso não
                //estamos passando o método _responder 
                //como parâmetro, e sim passando o retorno
                //deste método, já que o estamos executando
                //devido ao ();
                raisedButtonOnPressed: _responder // quandoSelecionado: _responder
              ),
              Resposta(
                raisedButtonText:'Resposta 2',
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
                raisedButtonOnPressed: _responder
                //O botão só fica habilitado para clique
                //caso seu onPressed seja != null
              ),
              Resposta(
                raisedButtonText: 'Resposta 3',
                raisedButtonOnPressed: _responder
              ),
              //Portanto ou passamos como referência uma
              //função que criamos ou passamos a função
              //de forma literal.
            */
          ]
        ),
      )
    );
  }
}

//Dentro da classe que extende o StatefulWidget, como
//a classe StatefulWidget é abstrata e possui um método
//abstrato, este precisa ser sobrescrito. Trata-se do
//método para criar um estado, o createState. Esse métod
//não recebe parâmetro, e pode retornar uma das duas 
//classes:
// _PerguntaAppState > a classe que extende o State<PerguntaApp>
// State<PerguntaApp> > direto retornar o state

//Já a classe que extende o StatefulWidget deixamos 
//público.
class PerguntaApp extends StatefulWidget {
  @override 
  _PerguntaAppState createState() => _PerguntaAppState();
}