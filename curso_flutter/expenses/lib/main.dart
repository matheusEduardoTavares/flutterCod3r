import 'package:flutter/material.dart';

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
          Card(
            child: Text('Lista de Transações'),
          ),
        ]
      )
    );
  }
}