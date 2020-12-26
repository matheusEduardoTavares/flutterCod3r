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
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        TransactionList(_transactions),
        TransactionForm()
      ],
    );
  }
}