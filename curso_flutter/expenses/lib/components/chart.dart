import 'chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransaction;

  const Chart(this.recentTransaction);

  double get _weekTotalValue {
    return groupedTransactions == null || groupedTransactions.isEmpty ?
      0.0 : groupedTransactions.fold(0.0, (accumulator, transaction) {
        return accumulator + transaction['value'];
      });
  }

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
      //Para inverter a lista é só usar o atributo 
      //reversed, mas isso os transforma em iterable,
      //daí é só usar um toList para voltar a ser uma lista
    }).reversed.toList();
  }

  double _getPercentage(double value){
    return _weekTotalValue == null || _weekTotalValue == 0 || value == 0 ? 0.0 : 
      value / _weekTotalValue;
  }

  @override 
  Widget build(BuildContext context){
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            //Usando um Flexible como wrap do ChartBar e 
            //alterando o parâmetro fit do Flexible 
            //que por default é FlexFit.loose para 
            //FlexFit.tight fará com que obrigatoriamente 
            //todos os elementos dentreo da row ocupem 
            //exatamente o mesmo tamanho, pois antes se 
            //o valor tinha um length maior aquela barra 
            //acaba ocupando mais espaço mesmo com o 
            //spaceAround.
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                percentage: _getPercentage(tr['value']),
              ),
            );
          }).toList(),
        ),
      )
    );
  }
}