import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'ExpensesApp',
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatelessWidget {
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            mainAxisSize: MainAxisSize.max,
            children: _transactions.map((transaction) => Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50,
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'R\$${transaction.value.toStringAsFixed(2)}',
                      ),
                    )
                  ),
                  Column(
                    children: <Widget>[
                      Text(transaction.title, style: TextStyle(color: Colors.black, fontSize: 16)),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(transaction.date.toString(), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            )).toList()
            //Ou:
            // children: <Widget>[
            //   ..._transactions.map((transaction) => Card(
            //     child: Text(transaction.title),
            //   )).toList()
            // ]
          ),
        ]
      )
    );
  }
}