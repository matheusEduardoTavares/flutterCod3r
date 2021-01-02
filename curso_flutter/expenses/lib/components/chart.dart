import 'chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction) {
    print('Constructor Chart');
  }

  double get _weekTotalValue {
    return groupedTransactions == null || groupedTransactions.isEmpty ?
      0.0 : groupedTransactions.fold(0.0, (accumulator, transaction) {
        return accumulator + transaction['value'];
      });
  }

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index)
      );

      List<double> values = recentTransaction
        ?.where((currentRecentTransaction) => currentRecentTransaction.date.day == weekDay.day && 
          currentRecentTransaction.date.month == weekDay.month && currentRecentTransaction.date.year == weekDay.year)
        ?.map((currentRecentTransaction) => currentRecentTransaction.value)?.toList();

      double totalSum = values != null && values.isNotEmpty ? 
        values.reduce((accumulator, value) => accumulator + value) : 0.0;

      return {
        'day': DateFormat.E().format(weekDay),
        'value': totalSum
      };
    }).reversed.toList();
  }

  double _getPercentage(double value){
    return _weekTotalValue == null || _weekTotalValue == 0 || value == 0 ? 0.0 : 
      value / _weekTotalValue;
  }

  @override 
  Widget build(BuildContext context){
    print('build() Chart');
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
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