import 'package:flutter/material.dart';
import 'transaction_item.dart';
import '../models/transaction.dart';

typedef DeleteTransaction = void Function(String);
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final DeleteTransaction onRemove;

  const TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    // print('build() TransactionList');
    return transactions.isEmpty ? LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Nenhuma Transação Cadastrada',
            style: Theme.of(context).textTheme.headline6
          ),
          const SizedBox(height: 20),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover
            ),
          ),
        ],
      )
    ) : 
      /* ListView(
        children: transactions.map((transaction) {
          return TransactionItem(
            key: ValueKey(transaction.id),
            transaction: transaction,
            onRemove: onRemove
          );
        }).toList(),
      ); */
    ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final transaction = transactions[index];
        return TransactionItem(
          key: GlobalObjectKey(transaction),
          transaction: transaction,
          onRemove: onRemove
        );
      }
    );
  }
}