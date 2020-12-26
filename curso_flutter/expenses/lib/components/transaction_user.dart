import 'dart:math';

import 'package:flutter/material.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

//Esse componente será do tipo stateful pois ele irá 
//precisar mexer, trabalhar em cima da lista de transações,
//embora a lista seja final, o conteúdo da lista poderá
//sendo alterado. A lista é final porque não mudaremos 
//a referência de memória para lista, mas seu conteúdo
//interno pode alterar.

class TransactionUser extends StatefulWidget {
  @override 
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser>{
  //Em um componente stateless, a única coisa que pode 
  //fazer com que sua UI seja atualizada é caso tal 
  //componente stateless esteja recebendo um parâmetro e
  //o valor desse parâmetro seja alterado (construtor).
  //É oque ocorrerá nesse caso, no TransactionList quando
  //atualizamos a lista _transactions .
  //Já nos componentes statefuls, eles também podem ser
  //atualizados dessa mesma forma, mas também podem ser
  //atualizados caso o estado desse componente stateful
  //seja alterado e assim a UI é renderizada novamente.

  //Apenas essas duas formas de comunicações não são 
  //suficientes para APP mais complexos, aí precisaremos
  //usar gerência de estados.

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

  void _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now()
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override 
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        //Exemplo de Comunicação direta entre 
        //Widgets:
        TransactionList(_transactions),
        //Exemplo de Comunicação indireta entre 
        //Widgets:
        TransactionForm(onSubmit: _addTransaction,)
      ],
    );
  }
}