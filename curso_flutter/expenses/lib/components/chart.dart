import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction>  recentTransaction;

  const Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions {
    //O List.generate retorna uma lista, e passamos como
    //parâmetro o tamanho, se queremos 7 elementos por 
    //exemplo, e como segundo parâmetro um callback que 
    //recebe como parâmetro o índice
    return List.generate(7, (index) {
      //Basicamente aqui, se o dia de hoje é quinta feira,
      //então quando pegarmos o datetime.now e der um 
      //subtract para um duration de 3 dias, significa
      //que o dia da semana que será pego é segunda-feira
      // final weekDay = DateTime.now().subtract(
      //   Duration(days: 3)
      // );
      final weekDay = DateTime.now().subtract(
        Duration(days: index)
      );

      List<double> values = recentTransaction
        ?.where((currentRecentTransaction) => currentRecentTransaction.date.day == weekDay.day && 
          currentRecentTransaction.date.month == weekDay.month && currentRecentTransaction.date.year == weekDay.year)
        ?.map((currentRecentTransaction) => currentRecentTransaction.value)?.toList();

      double totalSum = values != null && values.isNotEmpty ? 
        values.reduce((accumulator, value) => accumulator + value) : 0.0;

      //O construtor DateFormat.E() serve para pegar os
      //dados de um datetime que passarmos para o format
      //como parâmetro. Ele retornará por escrito o nome
      //do dia da semana referente a data passada no 
      //format. O [0] é para pegar a primeira letra do
      //nome do dia da semana.

      return {
        'day': DateFormat.E().format(weekDay),
        'value': totalSum
      };
    });
  }

  @override 
  Widget build(BuildContext context){
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactions.map((tr) {
          return Text(
            ' ${tr['day']}:${tr['value']} |'
          );
        }).toList(),
      )
    );
  }
}