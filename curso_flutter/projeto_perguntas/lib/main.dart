/*

import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';
import './resultado.dart';

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

  final _perguntas = const [
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
    if (temPerguntaSelecionada){
      setState(() {
        _perguntaSelecionada++;
      });
    }
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

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
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

    /*
      //Solução para iterar na lista e ir adicionando
      //um novo widget para cada resposta dentro da lista
      //do map de forma imperativa:
      List<Widget> respostas = [];
      for (var textoResp in perguntas[_perguntaSelecionada]['respostas']){
        respostas.add(Resposta(raisedButtonText: textoResp, raisedButtonOnPressed: _responder,));
      }
    */  

    /*
      //Solução para iterar na lista e ir adicionando
      //um novo widget para cada resposta dentro da lista
      //do map de forma funcional:
      List<String> respostas = perguntas[_perguntaSelecionada]['respostas'];
      List<Widget> widgets = respostas
        .map((t) => Resposta(raisedButtonText: t, raisedButtonOnPressed: _responder))
        .toList();

      //É interessante usar programação funcional sempre que
      //possível pois hoje em dia é muito necessário trabalhar
      //com programação concorrente e a programação funcional
      //ajuda muito nesse quesito, pois é bem mais simples 
      //trabalhar com programação concorrente usando também
      //programação funcional que OO, pois existem outros
      //conceitos acerca disso como dados imutáveis, etc.
    */  

    //A criação do nosso widget é o MaterialApp
    return MaterialApp(
      title: 'PerguntaApp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas')
        ),
        body: temPerguntaSelecionada ? Column(
          //Não precisa pow <Widget> (generics) para
          //explicitar o tipo da lista.
          children: [
            Questao(texto: _perguntas[_perguntaSelecionada]['texto']),
            if (temPerguntaSelecionada)
              ...(_perguntas[_perguntaSelecionada]['respostas'] as List<String>).map((resposta) => Resposta(
                raisedButtonText: resposta,
                raisedButtonOnPressed: _responder,
              )),
            //Operador Spread:
            // ...respostas
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
        ) : Resultado(),
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

*/

/*
import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questionario.dart';
import './resultado.dart';

main() => runApp(MaterialApp(home: PerguntaApp()));
class _PerguntaAppState extends State<PerguntaApp> {
  // Em relação a comunicação entre componentes temos uma
  // comunicação direta quando um componente pai passa
  // parâmetros para um componente filho, e temos a 
  // comunicação indireta, que é quando o componente pai
  // passa uma função para um componente filho para que o 
  // componente filho chame essa função, e de certa forma
  // o componente pai é notificado.
  //Na aula passada o componente pai, o PerguntaApp, passou
  //por parâmetro a pontuação total para o componente 
  //Resultado, seu filho. É um caso de comunicação direta,
  //de tal forma que o componente filho, o resultado, 
  //mostrou um dado valor. O componente questionario é 
  //outro exemplo de comunicação direta em relação aos 
  //parâmetros das perguntas, mas nele mesmo tem um caso 
  //de comunicação indireta também, que é a função 
  //responder, em que o componente filho pode chamar um 
  //método passando informação para o componente pai.
  //No caso do método responder, ele recebe por parâmetro
  //a pontuação, uma informação que virá do filho, 
  //e assim executará a função que está aqui, caracterizando
  //uma comunicação indireta.

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

    /*
    void _reiniciarQuestionario() {
      setState(() {
        _perguntaSelecionada = 0;
        _pontuacaoTotal = 0;
      });
    }
    */

    if (choose == null || choose == false) return;

    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'PerguntaApp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
          //No IOs o texto da AppBar por padrão já 
          //fica no centro, porém no Android seu padrão é
          //ficar na esquerda, setando o centerTitle como
          //true, ficará no centro para o Android também.
          centerTitle: true,
        ),
        body: temPerguntaSelecionada ? Questionario(
          hasSelectedQuestion: temPerguntaSelecionada,
          questions: _perguntas,
          selectedQuestion: _perguntaSelecionada,
          onPressed: _responder,
        ) : Resultado(pointing: _pontuacaoTotal, onPressedRestartApp: () => _restartApp(context),),
        // ) : Resultado(_pontuacaoTotal, _reiniciarQuestionario),
      )
    );
  }
}
class PerguntaApp extends StatefulWidget {
  @override 
  _PerguntaAppState createState() => _PerguntaAppState();
}
*/

import 'package:flutter/material.dart';
import 'package:projeto_perguntas/bodyScaffold.dart';

main() => runApp(MaterialApp(home: PerguntaApp()));
class PerguntaApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'PerguntaApp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
          centerTitle: true,
        ),
        body: const BodyScaffold(),
      )
    );
  }
}