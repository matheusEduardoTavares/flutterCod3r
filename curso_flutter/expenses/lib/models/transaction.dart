//Aqui criaremos uma classe de modelo que representa
//uma transação.

//Para usar as annotations @required não precisamos
//importar o flutter/material.dart pois será trazido
//muitas coisas que não precisamos. Como opção a esse
//import, podemos usar algum desses 2 imports:
//importar o package:meta/meta.dart , ou importar 
//o package:flutter/foundation.dart;
// import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  const Transaction({
    @required this.id,
    @required this.title,
    @required this.value,
    @required this.date
  });
}