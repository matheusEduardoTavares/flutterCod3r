import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './models/transaction.dart';
//Pacote de internacionalização que importamos no 
//pubspec.yaml para poder padronizar a formatação da
//data:
import 'package:intl/intl.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    //Definindo o locale default antes de inserir os 
    //localizationsDelegates. Com esse locale default
    //não é preciso passar pt_BR na hora de fazer a 
    //formatação pois esse já será o default.

    Intl.defaultLocale = 'pt_BR';
    
    return MaterialApp(
      title: 'ExpensesApp',
      //Importamos no pubspec.yaml o flutter_localizations
      //assim:
      //   flutter_localizations:
      //      sdk: flutter
      //importamos aqui esse pacote para termos acesso ao
      //GlobalMaterialLocalizations e ao 
      //GlobalWidgetsLocalizations
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('pt', 'BR')
      ],
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatelessWidget {
  //Não é indicado ter variáveis que não sejam final 
  //dentro de um componente stateless.

  //Mesmo marcando a variável como final, ainda sim 
  //iremos precisar alterar o estado interno dessa
  //variável, e não é bom mesmo que temos um atributo 
  //final mas que dentro deste atributo, é uma classe que
  //os estados internos dessa classe vão estar alterando,
  //o ideal ainda assim é colocar dentro de um componente
  //stateful;
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        centerTitle: true,
      ),
      body: Column(
        //A coluna coloca como default o alinhamento do
        //eixo X como centro, então podemos mudar isso caso
        //queremos que comece no início:
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //Para fazer o card ocupar todo espaço horizontal
          //da tela, podemos fazer um wrap dele em um 
          //Container e definir o width do container como
          //double.infinity, ou melhor ainda, é só fazer
          //a column ter CrossAxisAlignment.stretch .
          Container(
            child: Card(
              color: Colors.blue,
              child: Text('Gráfico'),
              //O elevation serve para dar uma noção de 
              //de 3D para destacar aquele (eixo z)
              //card, aumentando o sombreamento o quanto
              //maior for o valor do elevation (double)
              elevation: 5
            ),
          ),
          Column(
            children: _transactions.map((transaction) => Card(
              child: Row(
                children: <Widget>[
                  Container(
                    //O symmetric é para ser diferente no eixo vertical
                    //e no eixo horizontal
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      )
                    ),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      //Agora com o flutter_localizations,
                      //podemos formatar valor monetário de 
                      //uma forma mais interessante:
                      child: Text(
                        // 'R\$ ${transaction.value.toStringAsFixed(2).replaceAll('.', ',')}',
                        NumberFormat.currency(symbol: 'R\$', decimalDigits: 2).format(transaction.value),
                        //nesse caso não foi passado locale: 'pt_BR' pois isso
                        //já foi definido no Intl.defaultLocale = 'pt_BR';
                        //então não precisa, mas se não fosse definido como 
                        //default precisaríamos passar se não a moeda não 
                        //ficaria no formato brasileiro (ficaria . ao invés da ,
                        //na hora de definir os centavos)
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple,

                        )
                      ),
                    )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transaction.title, 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        //Data no formato:
                        // 26 Dec 2020
                        //Agora com o flutter_localizations,
                        //podemos passar um segundo parâmetro
                        //para o DateFormat, o 'pt_BR' , e
                        //assim a data é formatada para pt BR
                        //ficando:
                        //26 dez 2020
                        DateFormat('d MMM y', 'pt_BR').format(
                          transaction.date
                        ), 
                        //Data no formato: 
                        //December 26, 2020
                        // DateFormat.yMMMMd().format(transaction.date),
                        style: TextStyle(
                          color: Colors.grey
                        )
                      )
                    ],
                  )
                ],
              ),
            )).toList(),
            //Ou:
            // children: <Widget>[
            //   ..._transactions.map((transaction) => Card(
            //     child: Text(transaction.title),
            //   )).toList()
            // ]
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget> [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Título'
                    ),
                  ),
                  TextField(
                    //Usando um controller não precisa de um onChanged
                    //e ir sobrescrevendo o valor da variável referente 
                    //ao text field a partir do valor atual do onChanged,
                    //uma vez que muda automaticamente dentro do controller
                    //o estado do controller vai sendo alterado a partir
                    //do momento que vamos digitando as informações
                    controller: valueController,
                    decoration: InputDecoration(
                      labelText: 'Valor (R\$)'
                    )
                  ),
                  //Para deixar esse FlatButton alinhado 
                  //à esquerda, podemos ou na column que está
                  //em volta dele colocar o alinhamento do 
                  //cross axis para start, ou se for só este
                  //botão e não queremos mudar mais nenhum
                  //elemento de posição dentro da coluna, basta
                  //fazer um wrap neste FlatButton com um Align e 
                  //setar o alinhamento para bottomLeft por 
                  //exemplo, ou ainda fazer um wrap nele com uma
                  //Row por exemplo e arrumar seu alinhamento de
                  //main axis ou com uma Column e mexer no 
                  //cross axis.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        child: Text(
                          'Nova Transação'
                        ),
                        textColor: Colors.purple,
                        onPressed: () {
                          print(titleController.text);
                          print(valueController.text);
                        }
                      ),
                    ],
                  )
                ]
              ),
            )
          )
        ]
      )
    );
  }
}